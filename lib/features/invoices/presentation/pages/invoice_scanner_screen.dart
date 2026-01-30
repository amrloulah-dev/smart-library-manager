import 'dart:io';

import 'package:flutter/material.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Ensure responsiveness
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/theme/app_theme.dart';
import 'package:librarymanager/features/inventory/presentation/manager/inventory_cubit.dart';
import 'package:librarymanager/features/invoices/domain/models/scanned_item_model.dart';
import 'package:librarymanager/features/invoices/presentation/manager/invoice_scanner_cubit.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:librarymanager/features/inventory/presentation/widgets/manual_entry_sheet.dart';
import 'package:librarymanager/features/invoices/presentation/widgets/scanned_item_widget.dart';

class InvoiceScannerScreen extends StatelessWidget {
  const InvoiceScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I<InvoiceScannerCubit>()),
        // We reuse InventoryCubit to fetch suppliers
        BlocProvider.value(value: GetIt.I<InventoryCubit>()),
      ],
      child: const InvoiceScannerView(),
    );
  }
}

class InvoiceScannerView extends StatefulWidget {
  const InvoiceScannerView({super.key});

  @override
  State<InvoiceScannerView> createState() => _InvoiceScannerViewState();
}

class _InvoiceScannerViewState extends State<InvoiceScannerView> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _discountController = TextEditingController(
    text: '0',
  );
  final TextEditingController _paidAmountController = TextEditingController(
    text: '0',
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoiceScannerCubit, InvoiceScannerState>(
      listener: (context, state) {
        if (state.status == InvoiceScannerStatus.success &&
            state.successMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage!),
              backgroundColor: AppTheme.emeraldGreen,
            ),
          );
          context.read<InvoiceScannerCubit>().reset();
          _discountController.text = '0';
        }
        if (state.status == InvoiceScannerStatus.error &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: AppTheme.roseRed,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF0F172A), // Deep Navy
          appBar: AppBar(
            title: Text(
              'إضافة فاتورة شراء',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: const Color(0xFF0F172A),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              if (state.status == InvoiceScannerStatus.reviewing)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: IconButton(
                    icon: const Icon(Icons.add_a_photo),
                    tooltip: 'إضافة صفحة',
                    onPressed: () =>
                        _pickImage(ImageSource.camera, isAppending: true),
                  ),
                ),
            ],
          ),
          body: Builder(
            builder: (context) {
              if (state.status == InvoiceScannerStatus.scanning) {
                // Show loading indicator during processing
                return const Center(child: CustomLoadingIndicator());
              }
              if (state.status == InvoiceScannerStatus.reviewing) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: _buildReviewTable(context, state.scannedItems),
                );
              }

              // Initial State
              return _buildSetupView(context, state);
            },
          ),
        );
      },
    );
  }

  Widget _buildSetupView(BuildContext context, InvoiceScannerState state) {
    final cubit = context.read<InvoiceScannerCubit>();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Supplier Dropdown
          StreamBuilder<List<Supplier>>(
            stream: context.read<InventoryCubit>().suppliersStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const LinearProgressIndicator();
              final suppliers = snapshot.data!;
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2439),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Supplier>(
                    value: state.selectedSupplier, // Use state
                    hint: const Text(
                      'اختر المورد',
                      style: TextStyle(color: Colors.grey),
                    ),
                    dropdownColor: const Color(0xFF1E2439),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    items: suppliers.map((s) {
                      return DropdownMenuItem(
                        value: s,
                        child: Text(
                          s.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        cubit.selectSupplier(val); // No setState
                      }
                    },
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 16.h),

          // 2. Date Picker
          InkWell(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: state.invoiceDate, // Use state
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.dark(
                        primary: Color(0xFF3B82F6),
                        onPrimary: Colors.white,
                        surface: Color(0xFF1E2439),
                        onSurface: Colors.white,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (date != null) {
                cubit.updateDate(date); // No setState
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E2439),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.grey[400],
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    DateFormat('yyyy-MM-dd').format(state.invoiceDate),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 48.h),

          // 3. Choose Method Label
          Text(
            'اختر طريقة إدخال الفاتورة',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[400],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 24.h),

          // 4. Action Cards Row
          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  title: 'تصوير',
                  subtitle: 'فتح الكاميرا',
                  icon: Icons.camera_alt,
                  color: const Color(0xFF3B82F6), // Electric Blue
                  onTap: () => _pickImage(ImageSource.camera),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildActionCard(
                  title: 'من الجهاز',
                  subtitle: 'تحميل صورة',
                  icon: Icons.photo_library,
                  color: const Color(0xFF60A5FA), // Lighter Blue
                  onTap: () => _pickImage(ImageSource.gallery),
                ),
              ),
            ],
          ),

          SizedBox(height: 32.h),

          // 5. Bottom Link
          TextButton(
            onPressed: () {
              context.push('/inventory/manual_invoice');
            },
            child: Text(
              'أو ادخال البيانات يدوياً',
              style: TextStyle(
                color: const Color(0xFF3B82F6),
                fontSize: 16.sp,
                decoration: TextDecoration.underline,
                decorationColor: const Color(0xFF3B82F6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160.h,
        decoration: BoxDecoration(
          color: const Color(0xFF1E2439),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32.sp),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: TextStyle(color: Colors.grey[400], fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(
    ImageSource source, {
    bool isAppending = false,
  }) async {
    final cubit = context.read<InvoiceScannerCubit>();
    if (cubit.state.selectedSupplier == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء اختيار المورد أولاً'),
          backgroundColor: AppTheme.roseRed,
        ),
      );
      return;
    }

    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      if (!mounted) return;
      cubit.processImage(File(image.path), isAppending: isAppending);
    }
  }

  // --- Keeps existing Review Table Logic with minimal styling adaptions ---
  // --- Keeps existing Review Table Logic with minimal styling adaptions ---
  Widget _buildReviewTable(BuildContext context, List<ScannedItemModel> items) {
    // High-Fidelity Review UI
    final cubit = context.read<InvoiceScannerCubit>();

    // Calculate Totals locally for display
    double totalAmount = items.fold(
      0.0,
      (sum, item) => sum + (item.quantity * item.price),
    );

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        children: [
          // 1. Add Item Button
          Container(
            margin: EdgeInsets.only(bottom: 16.h),
            child: GestureDetector(
              onTap: () => _showManualEntrySheet(context),
              child: DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  color: const Color(0xFF3B82F6).withOpacity(0.5),
                  strokeWidth: 2,
                  dashPattern: const [8, 4],
                  radius: Radius.circular(16.r),
                ),
                child: Container(
                  width: double.infinity,
                  height: 56.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: const Color(0xFF3B82F6),
                        size: 24.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'إضافة صنف للفاتورة',
                        style: TextStyle(
                          color: const Color(0xFF3B82F6),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 2. Items List
          Expanded(
            child: items.isEmpty
                ? Center(
                    child: Text(
                      'لا توجد أصناف، أضف صنفًا',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.only(bottom: 100.h),
                    itemCount: items.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ScannedItemWidget(item: item, index: index);
                    },
                  ),
          ),

          // 3. Sticky Footer
          _buildStickyFooter(context, cubit, totalAmount, items),
        ],
      ),
    );
  }

  Widget _buildStickyFooter(
    BuildContext context,
    InvoiceScannerCubit cubit,
    double totalAmount,
    List<ScannedItemModel> items,
  ) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الإجمالي الكلي',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        '${totalAmount.toStringAsFixed(2)} EGP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: _discountController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'خصم %',
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.sp,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF0F172A),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 8.w,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Paid Amount Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'المبلغ المدفوع',
                  style: TextStyle(color: Colors.grey[400], fontSize: 12.sp),
                ),
                SizedBox(height: 8.h),
                TextField(
                  controller: _paidAmountController,
                  textAlign: TextAlign.center,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: '0.00',
                    hintStyle: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14.sp,
                    ),
                    suffixText: 'ج.م',
                    suffixStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12.sp,
                      fontFamily: 'Cairo',
                    ),
                    filled: true,
                    fillColor: const Color(0xFF0F172A),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 12.w,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: Text(
                  'حفظ الفاتورة',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.emeraldGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  if (cubit.state.selectedSupplier == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى اختيار مورد')),
                    );
                    return;
                  }
                  if (items.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('الفاتورة فارغة')),
                    );
                    return;
                  }

                  final discount =
                      double.tryParse(_discountController.text) ?? 0.0;
                  final paidAmount =
                      double.tryParse(_paidAmountController.text) ?? 0.0;
                  cubit.confirmAndSaveItems(discount, paidAmount: paidAmount);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showManualEntrySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ManualEntrySheet(
        onAdd: (manualItem) {
          // Convert ManualInvoiceItem to ScannedItemModel
          final scannedItem = ScannedItemModel(
            name: manualItem.bookName,
            quantity: manualItem.quantity,
            price: manualItem.costPrice,
            sellPrice: manualItem.sellPrice,
          );
          context.read<InvoiceScannerCubit>().addManualItem(scannedItem);
          Navigator.pop(context);
        },
      ),
    );
  }
}

// Extension to help with copyWith since Equatable doesn't generate it
extension ScannedItemCopy on ScannedItemModel {
  ScannedItemModel copyWith({
    String? code,
    String? name,
    int? quantity,
    double? price,
    double? sellPrice,
  }) {
    // Note: ScannedItemModel might need sellPrice if updated in other tasks,
    // assuming standard fields here as per existing file.
    return ScannedItemModel(
      code: code ?? this.code,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      sellPrice: sellPrice ?? this.sellPrice,
    );
  }
}
