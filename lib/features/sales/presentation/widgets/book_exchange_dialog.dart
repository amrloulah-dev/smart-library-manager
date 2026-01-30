import 'package:flutter/material.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/inventory/presentation/widgets/book_attribute_selector_sheet.dart';
import 'package:librarymanager/features/sales/presentation/manager/sales_cubit.dart';
import 'package:librarymanager/features/sales/presentation/manager/sales_state.dart';

/// Book Exchange Dialog
/// Allows selecting returned and new books with discounts
class BookExchangeDialog extends StatefulWidget {
  const BookExchangeDialog({super.key});

  @override
  State<BookExchangeDialog> createState() => _BookExchangeDialogState();
}

class _BookExchangeDialogState extends State<BookExchangeDialog> {
  Book? _returnedBook;
  Book? _newBook;
  final TextEditingController _returnDiscountController = TextEditingController(
    text: '0',
  );
  final TextEditingController _newDiscountController = TextEditingController(
    text: '0',
  );

  @override
  void dispose() {
    _returnDiscountController.dispose();
    _newDiscountController.dispose();
    super.dispose();
  }

  double get _returnDiscountPercent =>
      double.tryParse(_returnDiscountController.text) ?? 0;
  double get _newDiscountPercent =>
      double.tryParse(_newDiscountController.text) ?? 0;

  double get _netDifference {
    if (_returnedBook == null || _newBook == null) return 0;

    final returnPrice =
        _returnedBook!.sellPrice * (1 - _returnDiscountPercent / 100);
    final newPrice = _newBook!.sellPrice * (1 - _newDiscountPercent / 100);

    return newPrice - returnPrice;
  }

  Future<void> _selectReturnedBook() async {
    final book = await showModalBottomSheet<Book>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const BookAttributeSelectorSheet(
        title: 'الكتاب المرتجع',
        subtitle: 'اختر الكتاب المراد ارجاعه',
      ),
    );

    if (book != null) {
      setState(() {
        _returnedBook = book;
      });
    }
  }

  Future<void> _selectNewBook() async {
    final book = await showModalBottomSheet<Book>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const BookAttributeSelectorSheet(
        title: 'الكتاب البديل',
        subtitle: 'اختر الكتاب البديل',
      ),
    );

    if (book != null) {
      setState(() {
        _newBook = book;
      });
    }
  }

  void _handleConfirm() {
    if (_returnedBook == null || _newBook == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'الرجاء اختيار كلا الكتابين',
            style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp),
          ),
          backgroundColor: const Color(0xFFF43F5E),
        ),
      );
      return;
    }

    context.read<SalesCubit>().processBookExchange(
      returnedBook: _returnedBook!,
      returnDiscountPercent: _returnDiscountPercent,
      newBook: _newBook!,
      newDiscountPercent: _newDiscountPercent,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF0F172A), // Dark Navy
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6).withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.swap_horiz,
                      color: Color(0xFF3B82F6),
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'استبدال كتاب',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white54),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // Returned Book Section
              _buildReturnedSection(),
              SizedBox(height: 20.h),

              // Divider with Arrow
              _buildDivider(),
              SizedBox(height: 20.h),

              // New Book Section
              _buildNewSection(),
              SizedBox(height: 24.h),

              // Net Difference Card
              _buildNetDifferenceCard(),
              SizedBox(height: 24.h),

              // Confirm Button
              BlocConsumer<SalesCubit, SalesState>(
                listener: (context, state) {
                  if (state.status == SalesStatus.success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'تم الاستبدال بنجاح',
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
                      onPressed: isLoading ? null : _handleConfirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        disabledBackgroundColor: const Color(
                          0xFF3B82F6,
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
                                  'تأكيد الاستبدال',
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReturnedSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF43F5E).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.keyboard_return,
                color: Color(0xFFF43F5E),
                size: 20,
              ),
              SizedBox(width: 8.w),
              Text(
                'الكتاب المرتجع',
                style: TextStyle(
                  color: const Color(0xFFF43F5E),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Selector Button
          InkWell(
            onTap: _selectReturnedBook,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: const Color(0xFF111625),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _returnedBook?.name ?? 'اختر الكتاب المرتجع',
                      style: TextStyle(
                        color: _returnedBook != null
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

          if (_returnedBook != null) ...[
            SizedBox(height: 12.h),
            Row(
              children: [
                // Price
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'السعر',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12.sp,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${_returnedBook!.sellPrice.toStringAsFixed(2)} ج.م',
                        style: TextStyle(
                          color: const Color(0xFFF43F5E),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                // Discount
                SizedBox(
                  width: 100.w,
                  child: TextField(
                    controller: _returnDiscountController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontFamily: 'Cairo',
                    ),
                    decoration: InputDecoration(
                      labelText: 'خصم %',
                      labelStyle: TextStyle(
                        color: Colors.white54,
                        fontSize: 12.sp,
                        fontFamily: 'Cairo',
                      ),
                      filled: true,
                      fillColor: const Color(0xFF111625),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNewSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.library_books,
                color: Color(0xFF10B981),
                size: 20,
              ),
              SizedBox(width: 8.w),
              Text(
                'الكتاب البديل',
                style: TextStyle(
                  color: const Color(0xFF10B981),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Selector Button
          InkWell(
            onTap: _selectNewBook,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: const Color(0xFF111625),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _newBook?.name ?? 'اختر الكتاب البديل',
                      style: TextStyle(
                        color: _newBook != null ? Colors.white : Colors.white30,
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

          if (_newBook != null) ...[
            SizedBox(height: 12.h),
            Row(
              children: [
                // Price
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'السعر',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12.sp,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${_newBook!.sellPrice.toStringAsFixed(2)} ج.م',
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
                SizedBox(width: 12.w),
                // Discount
                SizedBox(
                  width: 100.w,
                  child: TextField(
                    controller: _newDiscountController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontFamily: 'Cairo',
                    ),
                    decoration: InputDecoration(
                      labelText: 'خصم %',
                      labelStyle: TextStyle(
                        color: Colors.white54,
                        fontSize: 12.sp,
                        fontFamily: 'Cairo',
                      ),
                      filled: true,
                      fillColor: const Color(0xFF111625),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(height: 1, color: Colors.white.withOpacity(0.1)),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w),
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2439),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: const Icon(
            Icons.arrow_downward,
            color: Colors.white54,
            size: 20,
          ),
        ),
        Expanded(
          child: Container(height: 1, color: Colors.white.withOpacity(0.1)),
        ),
      ],
    );
  }

  Widget _buildNetDifferenceCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF06B6D4).withOpacity(0.2),
            const Color(0xFF3B82F6).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF06B6D4).withOpacity(0.4)),
      ),
      child: Column(
        children: [
          Text(
            'فرق السعر (مستحق الدفع/الرد)',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14.sp,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_netDifference > 0)
                const Icon(
                  Icons.arrow_upward,
                  color: Color(0xFF06B6D4),
                  size: 24,
                )
              else if (_netDifference < 0)
                const Icon(
                  Icons.arrow_downward,
                  color: Color(0xFF10B981),
                  size: 24,
                ),
              SizedBox(width: 8.w),
              Text(
                '${_netDifference.abs().toStringAsFixed(2)} ج.م',
                style: TextStyle(
                  color: const Color(0xFF06B6D4),
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            _netDifference > 0
                ? 'مستحق على العميل'
                : _netDifference < 0
                ? 'رد للعميل'
                : 'متساوي',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12.sp,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }
}
