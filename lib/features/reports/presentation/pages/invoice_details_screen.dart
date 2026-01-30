import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:librarymanager/features/reports/domain/models/invoice_detail_model.dart';
import 'package:librarymanager/features/reports/presentation/manager/invoice_details_cubit.dart';

import 'package:url_launcher/url_launcher.dart';

class InvoiceDetailsScreen extends StatelessWidget {
  final String invoiceId;

  const InvoiceDetailsScreen({super.key, required this.invoiceId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetIt.I<InvoiceDetailsCubit>()..loadInvoice(invoiceId),
      child: BlocListener<InvoiceDetailsCubit, InvoiceDetailsState>(
        listener: (context, state) {
          if (state is InvoiceDeletedSuccess) {
            Navigator.pop(
              context,
              true,
            ); // Go back to history list with reload flag
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم حذف الفاتورة بنجاح'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        child: BlocBuilder<InvoiceDetailsCubit, InvoiceDetailsState>(
          builder: (context, state) {
            InvoiceDetailModel? details;
            if (state is InvoiceDetailsLoaded) {
              details = state.details;
            }

            return Scaffold(
              backgroundColor: const Color(0xFF0F172A), // Deep Navy
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  'تفاصيل الفاتورة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  if (details != null)
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _confirmDelete(context, details!),
                    ),
                ],
              ),
              body: Builder(
                builder: (context) {
                  if (state is InvoiceDetailsLoading) {
                    return const Center(child: CustomLoadingIndicator());
                  } else if (state is InvoiceDetailsError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state is InvoiceDetailsLoaded) {
                    return _buildContent(context, state.details);
                  }
                  return const SizedBox.shrink();
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, InvoiceDetailModel details) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1E2439),
        title: Text(
          'حذف الفاتورة',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
          textAlign: TextAlign.right,
        ),
        content: Text(
          'هل أنت متأكد من حذف هذه الفاتورة؟ سيتم التراجع عن المخزون وحساب المورد.',
          style: TextStyle(
            color: Colors.grey[300],
            fontSize: 14.sp,
            fontFamily: 'Cairo',
          ),
          textAlign: TextAlign.right,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'إلغاء',
              style: TextStyle(color: Colors.grey[400], fontFamily: 'Cairo'),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext); // Close Dialog
              _deleteInvoice(context, details);
            },
            child: Text(
              'حذف',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteInvoice(BuildContext context, InvoiceDetailModel details) {
    // Calling InvoiceDetailsCubit which is provided in this route
    context.read<InvoiceDetailsCubit>().deleteInvoice(details.invoice.id);
  }

  Widget _buildContent(BuildContext context, InvoiceDetailModel details) {
    final invoice = details.invoice;
    final supplier = details.supplier;
    final items = details.items;

    // ✅ FIX: Use actual database values for payment status with null safety
    final paidAmount =
        invoice.paidAmount ?? 0.0; // Handle null for legacy records
    final remaining = invoice.finalTotal - paidAmount;

    // Payment status with small margin for floating point comparison
    final isPaid = paidAmount >= (invoice.finalTotal - 0.01);

    final dateFormat = DateFormat('yyyy-MM-dd', 'ar');

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2439), // Dark Slate
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  _buildHeader(invoice, isPaid, dateFormat),
                  SizedBox(height: 24.h),

                  // Supplier Info
                  _buildSupplierInfo(supplier),
                  SizedBox(height: 24.h),

                  // Items Table
                  _buildItemsTable(items),
                  SizedBox(height: 24.h),

                  // Divider
                  Divider(color: Colors.grey[700], thickness: 1),
                  SizedBox(height: 16.h),

                  // Totals Section
                  _buildTotalsSection(invoice),
                  SizedBox(height: 24.h),

                  // Divider
                  Divider(color: Colors.grey[700], thickness: 1),
                  SizedBox(height: 16.h),

                  // Payment Info
                  _buildPaymentInfo(paidAmount, remaining),
                ],
              ),
            ),
          ),
        ),

        // Bottom Buttons
        _buildBottomButtons(context, details),
      ],
    );
  }

  void _shareViaWhatsApp(InvoiceDetailModel details) async {
    final invoice = details.invoice;
    final supplier = details.supplier;
    final paidAmount = invoice.paidAmount ?? 0.0;
    final remaining = invoice.finalTotal - paidAmount;

    final String message =
        'مرحباً، إليك تفاصيل الفاتورة من مكتبة الملك فهد:\n'
        'رقم الفاتورة: ${invoice.id.substring(0, 8)}\n'
        "التاريخ: ${DateFormat('yyyy-MM-dd').format(invoice.invoiceDate)}\n"
        '----------------\n'
        'الإجمالي: ${invoice.finalTotal.toStringAsFixed(2)} ج.م\n'
        'المدفوع: ${paidAmount.toStringAsFixed(2)} ج.م\n'
        'المتبقي: ${remaining.toStringAsFixed(2)} ج.م\n'
        '----------------\n'
        'شكراً لتعاملكم معنا!';

    final encodedMessage = Uri.encodeComponent(message);
    String? phone = supplier.phone?.trim();

    String url;
    if (phone != null && phone.isNotEmpty) {
      // Format for WhatsApp: Egypt +20
      if (phone.startsWith('01')) {
        phone = '20${phone.substring(1)}';
      }
      phone = phone.replaceAll('+', '').replaceAll(RegExp(r'\s+'), '');

      url = 'https://wa.me/$phone?text=$encodedMessage';
    } else {
      url = 'https://wa.me/?text=$encodedMessage';
    }

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildHeader(invoice, bool isPaid, DateFormat dateFormat) {
    return Column(
      children: [
        Text(
          'INV-2025-${invoice.id.length > 8 ? invoice.id.substring(0, 8) : invoice.id}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isPaid
                    ? const Color(0xFF10B981).withOpacity(0.2)
                    : Colors.redAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                isPaid ? 'مدفوعة' : 'غير مدفوعة',
                style: TextStyle(
                  color: isPaid ? const Color(0xFF10B981) : Colors.redAccent,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          dateFormat.format(invoice.invoiceDate),
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14.sp,
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }

  Widget _buildSupplierInfo(supplier) {
    return Column(
      children: [
        _buildInfoRow('العميل', supplier.name),
        SizedBox(height: 12.h),
        _buildInfoRow('العنوان', supplier.address ?? '-'),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14.sp,
            fontFamily: 'Cairo',
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontFamily: 'Cairo',
            ),
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildItemsTable(List<PurchaseItemWithBook> items) {
    return Column(
      children: [
        // Header Row
        Container(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: const Color(0xFF2D3748),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.r),
              topRight: Radius.circular(8.r),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'الصنف',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              Expanded(
                child: Text(
                  'الكمية',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'السعر',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'الإجمالي',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        // Items
        ...items.asMap().entries.map((entry) {
          final index = entry.key;
          final itemWithBook = entry.value;
          final item = itemWithBook.item;
          final total = item.quantity * item.unitCost;

          return Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
            decoration: BoxDecoration(
              color: index.isEven
                  ? const Color(0xFF1E2439)
                  : const Color(0xFF252D42),
              borderRadius: index == items.length - 1
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(8.r),
                      bottomRight: Radius.circular(8.r),
                    )
                  : null,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    itemWithBook.bookName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontFamily: 'Cairo',
                    ),
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: Text(
                    '${item.quantity}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontFamily: 'Cairo',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    item.unitCost.toStringAsFixed(0),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontFamily: 'Cairo',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    total.toStringAsFixed(0),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontFamily: 'Cairo',
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildTotalsSection(invoice) {
    return Column(
      children: [
        _buildTotalRow(
          'المجموع الفرعي',
          '${invoice.totalBeforeDiscount.toStringAsFixed(0)} ج.م',
          Colors.grey[300]!,
        ),
        SizedBox(height: 12.h),
        _buildTotalRow(
          'الخصم',
          '- ${(invoice.discountValue ?? 0.0).toStringAsFixed(0)} ج.م',
          Colors.redAccent,
        ),
        SizedBox(height: 16.h),
        _buildTotalRow(
          'الإجمالي النهائي',
          '${invoice.finalTotal.toStringAsFixed(0)} ج.م',
          const Color(0xFF3B82F6),
          isBold: true,
          fontSize: 18.sp,
        ),
      ],
    );
  }

  Widget _buildTotalRow(
    String label,
    String value,
    Color valueColor, {
    bool isBold = false,
    double? fontSize,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: fontSize ?? 14.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Cairo',
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: fontSize ?? 14.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentInfo(double paidAmount, double remaining) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'المدفوع',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12.sp,
                  fontFamily: 'Cairo',
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '${paidAmount.toStringAsFixed(0)} ج.م',
                style: TextStyle(
                  color: const Color(0xFF10B981),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'المتبقي',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12.sp,
                  fontFamily: 'Cairo',
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '${remaining.toStringAsFixed(0)} ج.م',
                style: TextStyle(
                  color: remaining > 0 ? Colors.orangeAccent : Colors.grey,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons(BuildContext context, InvoiceDetailModel details) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _shareViaWhatsApp(details),
              icon: const Icon(Icons.share, color: Colors.white),
              label: Text(
                'إرسال عبر واتساب',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25D366), // WhatsApp Green
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 4,
                shadowColor: const Color(0xFF25D366).withOpacity(0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
