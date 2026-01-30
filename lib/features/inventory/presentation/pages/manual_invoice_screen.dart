import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:librarymanager/app/injection.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/theme/app_theme.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:librarymanager/features/inventory/presentation/manager/inventory_cubit.dart';
import 'package:librarymanager/features/inventory/presentation/manager/manual_invoice_cubit.dart';
import 'package:librarymanager/features/inventory/presentation/manager/manual_invoice_state.dart';
import 'package:librarymanager/features/inventory/presentation/widgets/manual_entry_sheet.dart';
import 'package:intl/intl.dart';

class ManualInvoiceScreen extends StatelessWidget {
  const ManualInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ManualInvoiceCubit>()),
        BlocProvider.value(value: getIt<InventoryCubit>()),
      ],
      child: const _ManualInvoiceView(),
    );
  }
}

class _ManualInvoiceView extends StatelessWidget {
  const _ManualInvoiceView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF0F172A), // Deep Navy
      appBar: AppBar(
        title: Text(
          'فاتورة يدوية',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocConsumer<ManualInvoiceCubit, ManualInvoiceState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: AppTheme.roseRed,
              ),
            );
          }
          if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage!),
                backgroundColor: AppTheme.emeraldGreen,
              ),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        // Header: Supplier & Date
                        const SliverToBoxAdapter(child: _InvoiceHeader()),

                        // Add Item Button (Dashed)
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            child: _buildDottedAddButton(context),
                          ),
                        ),

                        // Items List
                        if (state.items.isEmpty)
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: _buildEmptyState(),
                          )
                        else
                          SliverPadding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate((
                                context,
                                index,
                              ) {
                                final item = state.items[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: _buildItemCard(context, item, index),
                                );
                              }, childCount: state.items.length),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Footer: Calculations & Save
                  const _InvoiceFooter(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.post_add, size: 64.sp, color: Colors.grey[700]),
          SizedBox(height: 16.h),
          Text(
            'الفاتورة فارغة',
            style: TextStyle(color: Colors.grey[500], fontSize: 16.sp),
          ),
          Text(
            'اضغط على الزر أعلاه لإضافة أصناف',
            style: TextStyle(color: Colors.grey[600], fontSize: 13.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildDottedAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showAddItemSheet(context),
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
    );
  }

  Widget _buildItemCard(
    BuildContext context,
    ManualInvoiceItem item,
    int index,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Row(
          children: [
            // Left Strip
            Container(
              width: 4.w,
              height: 100.h,
              color: const Color(0xFF3B82F6),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title & Delete
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.bookName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        InkWell(
                          onTap: () => context
                              .read<ManualInvoiceCubit>()
                              .removeItem(index),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.delete_outline,
                              color: AppTheme.roseRed,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.white.withOpacity(0.1), height: 16.h),

                    // Stats Grid
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildItemStat('الكمية', '${item.quantity}'),
                        _buildItemStat(
                          'شراء',
                          item.costPrice.toStringAsFixed(1),
                        ),
                        _buildItemStat(
                          'بيع',
                          item.sellPrice.toStringAsFixed(1),
                        ),
                        _buildItemStat(
                          'الاجمالي',
                          item.totalCost.toStringAsFixed(1),
                          isHighlight: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemStat(
    String label,
    String value, {
    bool isHighlight = false,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey[400], fontSize: 11.sp),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyle(
            color: isHighlight ? const Color(0xFF3B82F6) : Colors.white,
            fontSize: 14.sp,
            fontWeight: isHighlight ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _showAddItemSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Important for custom rounded sheet
      builder: (sheetContext) {
        return ManualEntrySheet(
          onAdd: (item) {
            context.read<ManualInvoiceCubit>().addItem(item);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}

class _InvoiceHeader extends StatelessWidget {
  const _InvoiceHeader();

  @override
  Widget build(BuildContext context) {
    final manualCubit = context.read<ManualInvoiceCubit>();
    final inventoryCubit = context.read<InventoryCubit>();

    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: const Color(0xFF1E2439), // Dark Slate
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            // Supplier
            StreamBuilder<List<Supplier>>(
              stream: inventoryCubit.suppliersStream,
              builder: (context, snapshot) {
                final suppliers = snapshot.data ?? [];

                return BlocBuilder<ManualInvoiceCubit, ManualInvoiceState>(
                  buildWhen: (previous, current) =>
                      previous.selectedSupplier != current.selectedSupplier,
                  builder: (context, state) {
                    return DropdownButtonFormField<String>(
                      decoration: _buildInputDecoration(
                        hint: 'اختر المورد',
                        icon: Icons.person_outline,
                      ),
                      dropdownColor: const Color(0xFF1E2439),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      style: const TextStyle(color: Colors.white),
                      initialValue: state.selectedSupplier?.id,
                      items: suppliers.map((s) {
                        return DropdownMenuItem(
                          value: s.id,
                          child: Text(s.name),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          final selected = suppliers.firstWhere(
                            (s) => s.id == val,
                          );
                          manualCubit.selectSupplier(selected);
                        }
                      },
                    );
                  },
                );
              },
            ),
            SizedBox(height: 12.h),

            // Date Picker (Already perfect)
            BlocBuilder<ManualInvoiceCubit, ManualInvoiceState>(
              buildWhen: (p, c) => p.invoiceDate != c.invoiceDate,
              builder: (context, state) {
                final dateStr = state.invoiceDate != null
                    ? DateFormat('yyyy-MM-dd').format(state.invoiceDate!)
                    : 'تاريخ الفاتورة';

                return InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: state.invoiceDate ?? DateTime.now(),
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
                    if (date != null) manualCubit.updateDate(date);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A), // Darker input bg
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Colors.grey[400],
                          size: 20.sp,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          dateStr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: hint,
      labelStyle: const TextStyle(color: Colors.grey),
      prefixIcon: Icon(icon, color: Colors.grey[400]),
      filled: true,
      fillColor: const Color(0xFF0F172A), // Darker input field background
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 1.5),
      ),
    );
  }
}

class _InvoiceFooter extends StatefulWidget {
  const _InvoiceFooter();

  @override
  State<_InvoiceFooter> createState() => _InvoiceFooterState();
}

class _InvoiceFooterState extends State<_InvoiceFooter> {
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _paidAmountController = TextEditingController();

  @override
  void dispose() {
    _discountController.dispose();
    _paidAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Total & Discount
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: BlocBuilder<ManualInvoiceCubit, ManualInvoiceState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'الإجمالي',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              '${state.totalCost.toStringAsFixed(2)} EGP',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
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
                      onChanged: (val) {
                        context.read<ManualInvoiceCubit>().updateDiscount(
                          double.tryParse(val) ?? 0.0,
                        );
                      },
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
                    onChanged: (val) {
                      context.read<ManualInvoiceCubit>().updatePaidAmount(
                        double.tryParse(val) ?? 0.0,
                      );
                    },
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
              SizedBox(height: 24.h),

              // Save Button
              BlocBuilder<ManualInvoiceCubit, ManualInvoiceState>(
                builder: (context, state) {
                  if (state.isSubmitting) {
                    return const Center(child: CustomLoadingIndicator());
                  }

                  return ElevatedButton(
                    onPressed: () {
                      context.read<ManualInvoiceCubit>().saveInvoice();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 4,
                      shadowColor: const Color(0xFF3B82F6).withOpacity(0.4),
                    ),
                    child: Text(
                      'حفظ الفاتورة',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
