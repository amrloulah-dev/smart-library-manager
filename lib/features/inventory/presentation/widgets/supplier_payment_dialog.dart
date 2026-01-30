import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/sales/presentation/manager/relations_cubit.dart';

class SupplierPaymentDialog extends StatefulWidget {
  final Supplier supplier;

  const SupplierPaymentDialog({super.key, required this.supplier});

  @override
  State<SupplierPaymentDialog> createState() => _SupplierPaymentDialogState();
}

class _SupplierPaymentDialogState extends State<SupplierPaymentDialog> {
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPayment =
      true; // true = Paying off debt (Green), false = Adding debt (Red)

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _processPayment() {
    if (_formKey.currentState?.validate() ?? false) {
      final amount = double.tryParse(_amountController.text.trim());
      if (amount != null && amount > 0) {
        final messenger = ScaffoldMessenger.of(context);

        // Process transaction using proper flag
        context.read<RelationsCubit>().processSupplierTransaction(
          widget.supplier.id,
          amount,
          isPayment: _isPayment,
        );

        Navigator.pop(context);

        messenger.showSnackBar(
          SnackBar(
            content: Text(
              _isPayment ? 'تم تسجيل الدفعة بنجاح' : 'تم إضافة الدين بنجاح',
            ),
            backgroundColor: _isPayment
                ? const Color(0xFF06B6D4)
                : Colors.orange,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine balance color: Red if we owe (balance > 0), Green if credit (balance <= 0)
    final balanceColor = widget.supplier.balance > 0
        ? Colors.red
        : Colors.green;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E2439), // Dark Navy
          borderRadius: BorderRadius.circular(20.r),
        ),
        padding: EdgeInsets.all(24.r),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  Expanded(
                    child: Text(
                      'تسديد دفعة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                  SizedBox(width: 24.w), // Balance the close button
                ],
              ),
              SizedBox(height: 24.h),

              // Supplier Info Box (Dark Container)
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A), // Darker background
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Column(
                  children: [
                    // Supplier Name
                    Text(
                      widget.supplier.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Balance Badge with Dynamic Color
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: balanceColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: balanceColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        widget.supplier.balance > 0
                            ? 'الرصيد المستحق: ${widget.supplier.balance.toStringAsFixed(2)} ج.م'
                            : 'رصيد دائن: ${widget.supplier.balance.abs().toStringAsFixed(2)} ج.م',
                        style: TextStyle(
                          color: balanceColor[400],
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Transaction Type Toggle
              Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: const Color(0xFF111625),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Expanded(child: _buildTypeOption('تسديد دفعة', true)),
                    Expanded(child: _buildTypeOption('إضافة دين', false)),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Input Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label
                  Text(
                    _isPayment ? 'المبلغ المدفوع' : 'قيمة الدين المضاف',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Input Field (Dark Filled, Rounded)
                  TextFormField(
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: '0.00',
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16.sp,
                      ),
                      suffixText: 'ج.م',
                      suffixStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14.sp,
                        fontFamily: 'Cairo',
                      ),
                      filled: true,
                      fillColor: const Color(0xFF111625), // Dark filled
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: const BorderSide(
                          color: Color(0xFF06B6D4), // Cyan focus
                          width: 1.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(
                          color: Colors.red[400]!,
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(
                          color: Colors.red[400]!,
                          width: 1.5,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 18.h,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'الرجاء إدخال المبلغ';
                      }
                      final amount = double.tryParse(value.trim());
                      if (amount == null || amount <= 0) {
                        return 'الرجاء إدخال مبلغ صحيح';
                      }
                      // Optional: Check if payment exceeds debt (only if balance > 0)
                      if (_isPayment &&
                          widget.supplier.balance > 0 &&
                          amount > widget.supplier.balance) {
                        return 'المبلغ أكبر من الدين المستحق';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // Buttons Row
              Row(
                children: [
                  // Cancel Button (Grey)
                  Expanded(
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D3748), // Grey
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(12.r),
                          child: Center(
                            child: Text(
                              'إلغاء',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Pay Button (Cyan)
                  Expanded(
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _processPayment,
                          borderRadius: BorderRadius.circular(12.r),
                          child: Center(
                            child: Text(
                              _isPayment ? 'تسديد' : 'حفظ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeOption(String title, bool isPaymentOption) {
    final isSelected = _isPayment == isPaymentOption;
    final color = isPaymentOption
        ? const Color(0xFF06B6D4)
        : Colors.orange; // Cyan vs Orange

    return GestureDetector(
      onTap: () => setState(() => _isPayment = isPaymentOption),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[500],
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
      ),
    );
  }
}
