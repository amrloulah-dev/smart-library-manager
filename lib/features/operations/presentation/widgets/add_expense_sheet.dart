import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:librarymanager/features/operations/presentation/manager/expenses_cubit.dart';
import 'package:librarymanager/features/operations/presentation/manager/expense_form_cubit.dart';
import 'package:librarymanager/features/operations/presentation/manager/expense_form_state.dart';

class AddExpenseSheet extends StatefulWidget {
  const AddExpenseSheet({super.key});

  @override
  State<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends State<AddExpenseSheet> {
  final TextEditingController _amountController = TextEditingController();

  final List<Map<String, dynamic>> _categories = [
    {'name': 'كهرباء', 'id': 'Electricity', 'icon': Icons.bolt_rounded},
    {'name': 'بوفيه', 'id': 'Buffet', 'icon': Icons.coffee_rounded},
    {'name': 'نقل', 'id': 'Transport', 'icon': Icons.local_shipping_rounded},
    {'name': 'أخرى', 'id': 'Other', 'icon': Icons.inventory_2_rounded},
  ];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _onConfirm(BuildContext context, int selectedCategoryIndex) {
    final amountText = _amountController.text.trim();
    if (amountText.isEmpty) return;

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) return;

    context.read<ExpensesCubit>().addExpense(
      amount: amount,
      category: _categories[selectedCategoryIndex]['name'],
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<ExpenseFormCubit>(),
      child: BlocBuilder<ExpenseFormCubit, ExpenseFormState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
              top: 10.h,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2439),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag Handle
                  Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                      ),
                      Text(
                        'تسجيل مصروف',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      SizedBox(width: 36.w), // Balance out the close button
                    ],
                  ),
                  SizedBox(height: 40.h),

                  // Amount Input (Hero)
                  Column(
                    children: [
                      Text(
                        'المبلغ المدفوع',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 14.sp,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      IntrinsicWidth(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          textAlign: TextAlign.center,
                          autofocus: true,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                          cursorColor: const Color(0xFFF97316),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '0.00',
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.1),
                              fontSize: 50.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                            suffixText: ' ج.م',
                            suffixStyle: TextStyle(
                              color: Colors.white54,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 2.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFF97316), Color(0xFFEF4444)],
                          ),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),

                  // Categories
                  SizedBox(
                    height: 100.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(_categories.length, (index) {
                        final isSelected = state.selectedCategoryIndex == index;

                        return GestureDetector(
                          onTap: () {
                            context.read<ExpenseFormCubit>().selectCategory(
                              index,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60.w,
                                  height: 60.w,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFFF97316)
                                        : const Color(0xFF111625),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFFF97316)
                                          : Colors.white.withOpacity(0.1),
                                      width: 2.w,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: const Color(
                                                0xFFF97316,
                                              ).withOpacity(0.4),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ]
                                        : [],
                                  ),
                                  child: Icon(
                                    _categories[index]['icon'],
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey,
                                    size: 28.sp,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  _categories[index]['name'],
                                  style: TextStyle(
                                    color: isSelected
                                        ? const Color(0xFFF97316)
                                        : Colors.grey,
                                    fontSize: 12.sp,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 40.h),

                  // Confirm Button
                  SizedBox(
                    width: double.infinity,
                    height: 55.h,
                    child: ElevatedButton(
                      onPressed: () =>
                          _onConfirm(context, state.selectedCategoryIndex),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEF4444),
                        foregroundColor: Colors.white,
                        shadowColor: const Color(0xFFEF4444).withOpacity(0.4),
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        'تأكيد المصروف',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
