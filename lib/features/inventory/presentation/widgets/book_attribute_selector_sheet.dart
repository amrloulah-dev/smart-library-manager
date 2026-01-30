import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:librarymanager/core/constants/book_constants.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:librarymanager/features/inventory/domain/models/book_search_query.dart';
import 'package:librarymanager/features/inventory/domain/repositories/inventory_repository.dart';

/// Reusable Book Attribute Selector Sheet
/// Returns selected Book to parent via Navigator.pop
class BookAttributeSelectorSheet extends StatefulWidget {
  final String title;
  final String subtitle;

  const BookAttributeSelectorSheet({
    super.key,
    this.title = 'اختر كتاب',
    this.subtitle = 'حدد تفاصيل الكتاب',
  });

  @override
  State<BookAttributeSelectorSheet> createState() =>
      _BookAttributeSelectorSheetState();
}

class _BookAttributeSelectorSheetState
    extends State<BookAttributeSelectorSheet> {
  String? _selectedPublisher;
  String? _selectedSubject;
  String? _selectedGrade;

  bool _isLoading = false;
  Book? _foundBook;

  Future<void> _searchBook() async {
    // Debug: Log current selections

    if (_selectedPublisher == null ||
        _selectedSubject == null ||
        _selectedGrade == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'الرجاء اختيار جميع الحقول',
            style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp),
          ),
          backgroundColor: const Color(0xFFF43F5E),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _foundBook = null;
    });

    try {
      final query = BookSearchQuery(
        publisher: _selectedPublisher!,
        subject: _selectedSubject!,
        grade: _selectedGrade!,
        term: 'ج2',
      );

      final books = await GetIt.I<InventoryRepository>().findBookByAttributes(
        query,
      );

      if (!mounted) return;

      if (books.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'الكتاب غير موجود في المخزون',
              style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp),
            ),
            backgroundColor: const Color(0xFFF43F5E),
          ),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Show the found book
      setState(() {
        _foundBook = books.first;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'حدث خطأ: ${e.toString()}',
            style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp),
          ),
          backgroundColor: const Color(0xFFF43F5E),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleConfirm() {
    if (_foundBook == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'الرجاء البحث عن الكتاب أولاً',
            style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp),
          ),
          backgroundColor: const Color(0xFFF43F5E),
        ),
      );
      return;
    }

    // Return the found book
    Navigator.pop(context, _foundBook);
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
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          Text(
                            widget.subtitle,
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 13.sp,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Form Content
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Publisher Dropdown
                    _buildLabel('الناشر'),
                    SizedBox(height: 8.h),
                    _buildDropdown(
                      value: _selectedPublisher,
                      items: BookConstants.publishers,
                      hint: 'اختر الناشر',
                      onChanged: (value) {
                        setState(() {
                          _selectedPublisher = value;
                          _foundBook = null;
                        });
                      },
                    ),
                    SizedBox(height: 16.h),

                    // Subject Dropdown
                    _buildLabel('المادة'),
                    SizedBox(height: 8.h),
                    _buildDropdown(
                      value: _selectedSubject,
                      items: BookConstants.subjects,
                      hint: 'اختر المادة',
                      onChanged: (value) {
                        setState(() {
                          _selectedSubject = value;
                          _foundBook = null;
                        });
                      },
                    ),
                    SizedBox(height: 16.h),

                    // Grade Dropdown
                    _buildLabel('الصف'),
                    SizedBox(height: 8.h),
                    _buildDropdown(
                      value: _selectedGrade,
                      items: BookConstants.grades,
                      hint: 'اختر الصف',
                      onChanged: (value) {
                        setState(() {
                          _selectedGrade = value;
                          _foundBook = null;
                        });
                      },
                    ),
                    SizedBox(height: 24.h),

                    // Search Button
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _searchBook,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B82F6),
                          disabledBackgroundColor: const Color(
                            0xFF3B82F6,
                          ).withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CustomLoadingIndicator(
                                  size: 24,
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.search, color: Colors.white),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'بحث',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),

                    // Found Book Display Card
                    if (_foundBook != null) ...[
                      SizedBox(height: 20.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: const Color(0xFF10B981).withOpacity(0.4),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF10B981),
                                  size: 20,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'تم العثور على الكتاب',
                                  style: TextStyle(
                                    color: const Color(0xFF10B981),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              _foundBook!.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Cairo',
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'السعر:',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13.sp,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                                Text(
                                  '${_foundBook!.sellPrice.toStringAsFixed(2)} ر.س',
                                  style: TextStyle(
                                    color: const Color(0xFF10B981),
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],

                    SizedBox(height: 24.h),

                    // Confirm Button
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: ElevatedButton(
                        onPressed: _foundBook == null ? null : _handleConfirm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B82F6),
                          disabledBackgroundColor: const Color(
                            0xFF3B82F6,
                          ).withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          elevation: 4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              color: Colors.white,
                              size: 24,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'تأكيد الاختيار',
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white70,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'Cairo',
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required String hint,
    required ValueChanged<String?> onChanged,
    String Function(String)? displayMapper,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111625),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: TextStyle(
              color: Colors.white30,
              fontSize: 15.sp,
              fontFamily: 'Cairo',
            ),
          ),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white54),
          dropdownColor: const Color(0xFF111625),
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.sp,
            fontFamily: 'Cairo',
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(displayMapper != null ? displayMapper(item) : item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
