import 'package:flutter/material.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/inventory/presentation/widgets/book_attribute_selector_sheet.dart';
import 'package:librarymanager/features/sales/presentation/manager/sales_cubit.dart';
import 'package:librarymanager/features/sales/presentation/manager/sales_state.dart';

/// Customer Return Bottom Sheet
/// Allows selecting a book by attributes and processing a return
class CustomerReturnSheet extends StatefulWidget {
  const CustomerReturnSheet({super.key});

  @override
  State<CustomerReturnSheet> createState() => _CustomerReturnSheetState();
}

class _CustomerReturnSheetState extends State<CustomerReturnSheet> {
  Book? _selectedBook;
  final TextEditingController _discountController = TextEditingController();
  double _returnDiscountPercentage = 0;

  @override
  void dispose() {
    _discountController.dispose();
    super.dispose();
  }

  Future<void> _selectBook() async {
    final book = await showModalBottomSheet<Book>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const BookAttributeSelectorSheet(
        title: 'ارجاع كتاب',
        subtitle: 'اختر الكتاب المراد ارجاعه',
      ),
    );

    if (book != null) {
      setState(() {
        _selectedBook = book;
      });
    }
  }

  void _handleConfirmReturn() {
    if (_selectedBook == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'الرجاء اختيار كتاب صحيح أولاً',
            style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp),
          ),
          backgroundColor: const Color(0xFFF43F5E),
        ),
      );
      return;
    }

    context.read<SalesCubit>().processCustomerReturnWithBook(
      _selectedBook!,
      discountPercentage: _returnDiscountPercentage,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439), // Dark Slate
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8.h),

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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    // Close Button
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 8.w),

                    // Title Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ارجاع كتاب',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          Text(
                            'اختر تفاصيل الكتاب',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 13.sp,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Arrow Icon
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF43F5E).withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.keyboard_return,
                        color: Color(0xFFF43F5E),
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Content
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Book Selector Button
                    InkWell(
                      onTap: _selectBook,
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF111625), // Darker fill
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: _selectedBook != null
                                ? const Color(0xFFF43F5E).withOpacity(0.5)
                                : Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.library_books,
                              color: Color(0xFFF43F5E),
                              size: 20,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                _selectedBook?.name ??
                                    'اختر الكتاب المراد ارجاعه',
                                style: TextStyle(
                                  color: _selectedBook != null
                                      ? Colors.white
                                      : Colors.white30,
                                  fontSize: 14.sp,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white54,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (_selectedBook != null) ...[
                      SizedBox(height: 20.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF111625),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: const Color(0xFFF43F5E).withOpacity(0.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'تفاصيل الكتاب',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13.sp,
                                fontFamily: 'Cairo',
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'المخزون المتاح:',
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 12.sp,
                                          fontFamily: 'Cairo',
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        '${_selectedBook!.currentStock} كتاب',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Cairo',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'سعر البيع الأصلي:',
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 12.sp,
                                        fontFamily: 'Cairo',
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      '${_selectedBook!.sellPrice.toStringAsFixed(2)} ج.م',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Cairo',
                                        decoration:
                                            _returnDiscountPercentage > 0
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                // Discount Input
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.1),
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: _discountController,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'نسبة الخصم %',
                                        labelStyle: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 12.sp,
                                          fontFamily: 'Cairo',
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 8.h,
                                        ),
                                        suffixText: '%',
                                        suffixStyle: TextStyle(
                                          color: const Color(0xFFF43F5E),
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          _returnDiscountPercentage =
                                              double.tryParse(value) ?? 0;
                                          if (_returnDiscountPercentage > 100) {
                                            _returnDiscountPercentage = 100;
                                          } else if (_returnDiscountPercentage <
                                              0) {
                                            _returnDiscountPercentage = 0;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                // Final Refund Amount
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'صافي الاسترداد',
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 12.sp,
                                        fontFamily: 'Cairo',
                                      ),
                                    ),
                                    Text(
                                      '${(_selectedBook!.sellPrice * (1 - _returnDiscountPercentage / 100)).toStringAsFixed(2)} ج.م',
                                      style: TextStyle(
                                        color: const Color(0xFF10B981),
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Cairo',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],

                    SizedBox(height: 32.h),

                    // Confirm Button
                    BlocConsumer<SalesCubit, SalesState>(
                      listener: (context, state) {
                        if (state.status == SalesStatus.success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'تم الإرجاع بنجاح',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 14.sp,
                                ),
                              ),
                              backgroundColor: const Color(0xFF10B981),
                            ),
                          );
                        } else if (state.status == SalesStatus.error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                state.errorMessage ?? 'حدث خطأ',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 14.sp,
                                ),
                              ),
                              backgroundColor: const Color(0xFFF43F5E),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        final isLoading = state.status == SalesStatus.scanning;
                        return SizedBox(
                          width: double.infinity,
                          height: 55.h,
                          child: ElevatedButton(
                            onPressed: isLoading || _selectedBook == null
                                ? null
                                : _handleConfirmReturn,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF43F5E), // Red
                              disabledBackgroundColor: const Color(
                                0xFFF43F5E,
                              ).withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              elevation: 4,
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CustomLoadingIndicator(size: 20),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      SizedBox(width: 12.w),
                                      Text(
                                        'تأكيد الإرجاع',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Cairo',
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
