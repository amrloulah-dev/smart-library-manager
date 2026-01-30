import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:librarymanager/core/database/app_database.dart';

class ReservedItemCard extends StatelessWidget {
  final Reservation reservation;

  const ReservedItemCard({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h, left: 20.w, right: 20.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          // Image Placeholder
          Container(
            width: 48.w,
            height: 64.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.book, color: Colors.white24, size: 24.sp),
          ),
          SizedBox(width: 12.w),
          // Info Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reservation.bookName,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    fontSize: 14.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: const Color(0xFF3B82F6),
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      reservation.customerName,
                      style: TextStyle(
                        color: const Color(0xFF3B82F6), // Blue
                        fontSize: 12.sp,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Red Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              '1 نسخة', // Hardcoded 1 for now as per logic
              style: TextStyle(
                color: const Color(0xFFEF4444),
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShortageItemCard extends StatelessWidget {
  final Book book;

  const ShortageItemCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final missing = book.minLimit - book.currentStock;
    return Container(
      margin: EdgeInsets.only(bottom: 12.h, left: 20.w, right: 20.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          // Image Placeholder
          Container(
            width: 48.w,
            height: 64.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.menu_book, color: Colors.white24, size: 24.sp),
          ),
          SizedBox(width: 12.w),
          // Info Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    fontSize: 14.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  book.publisher ?? 'Unknown Publisher',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12.sp,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),
          // Orange Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF97316).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              'الناقص ${missing > 0 ? missing : 0}',
              style: TextStyle(
                color: const Color(0xFFF97316), // Orange
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
