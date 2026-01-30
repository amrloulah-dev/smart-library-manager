import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:librarymanager/features/sales/presentation/manager/relations_cubit.dart';
import 'package:librarymanager/features/operations/presentation/manager/reservation_form_cubit.dart';
import 'package:librarymanager/features/operations/presentation/manager/reservation_form_state.dart';

class AddReservationSheet extends StatefulWidget {
  const AddReservationSheet({super.key});

  @override
  State<AddReservationSheet> createState() => _AddReservationSheetState();
}

class _AddReservationSheetState extends State<AddReservationSheet> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bookNameController = TextEditingController();
  final _depositController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _bookNameController.dispose();
    _depositController.dispose();
    super.dispose();
  }

  void _saveReservation(BuildContext context, ReservationFormState state) {
    if (_nameController.text.trim().isEmpty ||
        (state.selectedBook == null &&
            _bookNameController.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('الرجاء ملء الحقول المطلوبة'),
          backgroundColor: Colors.red[700],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      );
      return;
    }

    // Use values from controllers for exact text at submit time, or state if synced
    final deposit = double.tryParse(_depositController.text.trim()) ?? 0.0;
    // Prefer state if available, but for text fields pure Controller is usually standard unless validation needed per keystroke

    // However, the selectedBook is definitely in state.
    // If no book selected, use the text as bookName.
    final bookName =
        state.selectedBook?.name ?? _bookNameController.text.trim();

    context.read<RelationsCubit>().addReservation(
      customerName: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      bookName: bookName,
      deposit: deposit,
      bookId: state.selectedBook?.id,
    );

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          state.selectedBook != null
              ? 'تم إضافة الحجز وربطه بالمخزون'
              : 'تم إضافة الحجز',
        ),
        backgroundColor: const Color(0xFF3B82F6),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<ReservationFormCubit>(),
      child: BlocBuilder<ReservationFormCubit, ReservationFormState>(
        builder: (context, state) {
          // Sync book name if book selected
          if (state.selectedBook != null &&
              _bookNameController.text != state.selectedBook!.name) {
            _bookNameController.text = state.selectedBook!.name;
          } else if (state.selectedBook == null &&
              _bookNameController.text.isNotEmpty &&
              state.searchResults.isEmpty &&
              !state.isSearching) {
            // User typed something not found, let it be.
          }

          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E2439),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Handle
                      Center(
                        child: Container(
                          width: 40.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Header
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundColor: Colors.grey[800],
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'إضافة حجز جديد',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // Customer Name
                      _buildLabel('اسم العميل'),
                      SizedBox(height: 8.h),
                      _buildTextField(
                        controller: _nameController,
                        hint: 'أدخل اسم العميل',
                        icon: Icons.person_outline,
                        onChanged: (val) => context
                            .read<ReservationFormCubit>()
                            .updateName(val),
                      ),
                      SizedBox(height: 16.h),

                      // Phone
                      _buildLabel('رقم الموبايل'),
                      SizedBox(height: 8.h),
                      _buildTextField(
                        controller: _phoneController,
                        hint: 'أدخل رقم الموبايل',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        onChanged: (val) => context
                            .read<ReservationFormCubit>()
                            .updatePhone(val),
                      ),
                      SizedBox(height: 16.h),

                      // Book Name (Smart Search)
                      _buildLabel('اسم الكتاب'),
                      SizedBox(height: 8.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _bookNameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'ابحث عن كتاب أو اكتب الاسم',
                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14.sp,
                              ),
                              prefixIcon: Icon(
                                Icons.book_outlined,
                                color: Colors.grey[500],
                                size: 22.sp,
                              ),
                              suffixIcon: state.selectedBook != null
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        _bookNameController.clear();
                                        context
                                            .read<ReservationFormCubit>()
                                            .clearSelection();
                                      },
                                    )
                                  : state.isSearching
                                  ? Padding(
                                      padding: EdgeInsets.all(12.r),
                                      child: SizedBox(
                                        width: 20.w,
                                        height: 20.h,
                                        child: const CustomLoadingIndicator(
                                          size: 20,
                                        ),
                                      ),
                                    )
                                  : null,
                              filled: true,
                              fillColor: const Color(0xFF111625),
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
                                  color: Color(0xFF3B82F6),
                                  width: 1.5,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 18.h,
                              ),
                            ),
                            onChanged: (val) => context
                                .read<ReservationFormCubit>()
                                .searchBooks(val),
                          ),

                          // Selected Book Indicator
                          if (state.selectedBook != null)
                            Container(
                              margin: EdgeInsets.only(top: 8.h),
                              padding: EdgeInsets.all(12.r),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: const Color(
                                    0xFF10B981,
                                  ).withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: Color(0xFF10B981),
                                    size: 20,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                      'مربوط بالمخزون (متوفر: ${state.selectedBook!.currentStock})',
                                      style: TextStyle(
                                        color: const Color(0xFF10B981),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // Search Results
                          if (state.searchResults.isNotEmpty &&
                              state.selectedBook == null)
                            Container(
                              margin: EdgeInsets.only(top: 8.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFF111625),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.1),
                                ),
                              ),
                              constraints: BoxConstraints(maxHeight: 200.h),
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: state.searchResults.length,
                                separatorBuilder: (context, index) => Divider(
                                  color: Colors.white.withOpacity(0.05),
                                  height: 1,
                                ),
                                itemBuilder: (context, index) {
                                  final book = state.searchResults[index];
                                  return ListTile(
                                    leading: const Icon(
                                      Icons.book,
                                      color: Color(0xFF3B82F6),
                                    ),
                                    title: Text(
                                      book.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'متوفر: ${book.currentStock} | ${book.sellPrice.toStringAsFixed(2)} ج.م',
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    onTap: () {
                                      context
                                          .read<ReservationFormCubit>()
                                          .selectBook(book);
                                      // Controller update happens in build if needed, or we can set it here too but better if state drives it
                                    },
                                  );
                                },
                              ),
                            ),

                          // No match indicator
                          if (_bookNameController.text.isNotEmpty &&
                              state.searchResults.isEmpty &&
                              !state.isSearching &&
                              state.selectedBook == null)
                            Container(
                              margin: EdgeInsets.only(top: 8.h),
                              padding: EdgeInsets.all(12.r),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: Colors.orange.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.info_outline,
                                    color: Colors.orange,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                      'الكتاب غير موجود في المخزون - سيتم حفظه كنص فقط',
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      // Deposit Amount
                      _buildLabel('المبلغ الذي هيدفعه'),
                      SizedBox(height: 8.h),
                      TextField(
                        controller: _depositController,
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
                          prefixIcon: Icon(
                            Icons.attach_money,
                            color: Colors.grey[500],
                            size: 22.sp,
                          ),
                          suffixText: 'ج.م',
                          suffixStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14.sp,
                          ),
                          filled: true,
                          fillColor: const Color(0xFF111625),
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
                              color: Color(0xFF3B82F6),
                              width: 1.5,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 18.h,
                          ),
                        ),
                        onChanged: (val) => context
                            .read<ReservationFormCubit>()
                            .updateDeposit(val),
                      ),
                      SizedBox(height: 28.h),

                      // Confirm Button
                      ElevatedButton.icon(
                        onPressed: () => _saveReservation(context, state),
                        icon: const Icon(Icons.check_circle, size: 20),
                        label: Text(
                          'تأكيد الحجز',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B82F6),
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 55.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey[400],
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'Cairo',
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
        prefixIcon: Icon(icon, color: Colors.grey[500], size: 22.sp),
        filled: true,
        fillColor: const Color(0xFF111625),
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
          borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      ),
      onChanged: onChanged,
    );
  }
}
