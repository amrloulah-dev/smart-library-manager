import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:librarymanager/features/reports/presentation/manager/shortages_cubit.dart';

class SmartShortageCard extends StatelessWidget {
  final ShortageItem item;

  const SmartShortageCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final bookName = item.book?.name ?? 'كتاب غير معروف';
    final bookStock = item.book?.currentStock ?? 0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439), // Dark Slate
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          // Part 1: Main Info (Top Section)
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2439),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              children: [
                // Right: Book Cover Image (Rounded)
                Container(
                  width: 50.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: item.book == null
                      ? const Icon(Icons.book, color: Colors.white)
                      : null,
                ),
                SizedBox(width: 12.w),

                // Center: Book Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bookName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'المخزون الحالي: $bookStock',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12.sp,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),

                // Left: Suggested Qty
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: const Color(0xFF3B82F6),
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'اطلب:',
                          style: TextStyle(
                            color: const Color(0xFF3B82F6),
                            fontSize: 12.sp,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${item.quantity}',
                      style: TextStyle(
                        color: const Color(0xFF3B82F6),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Part 2: The AI Footer (Bottom Section)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFF312E81), // Deep Indigo
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Icon(
                    Icons.auto_awesome,
                    color: Colors.amber,
                    size: 16.sp,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'تحليل AI:',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                    fontFamily: 'Cairo',
                  ),
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    _getArabicReason(item.reason),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13.sp,
                      fontFamily: 'Cairo',
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getArabicReason(String englishReason) {
    String reason = englishReason;

    // Explicit full phrase replacements to remove hardcoded numbers
    if (reason.contains('Trending Up')) {
      reason = reason.replaceAll(RegExp(r'Trending Up.*'), 'الطلب يتزايد 📈');
    }

    final replacements = {
      'Velocity:': 'معدل البيع:',
      '/day': '/يوم',
      'Trending Down': 'الطلب يتراجع 📉', // Clean replacement
      'Sales Slowing Down': 'الطلب يتراجع 📉',
      'Season Peak': 'ذروة الموسم 🔥',
      'End of Season approaching': 'نهاية الموسم تقترب ⏳',
      'Season Ending soon': 'نهاية الموسم تقترب ⏳',
      'Market saturated': 'السوق مشبع 🛑',
      'Market nearly saturated': 'السوق مشبع 🛑',
      'Critical Stock': 'مخزون حرج ⚠️',
      'Normal Replenishment': 'إعادة تعبئة عادية 📦',
      'Sufficient Stock': 'المخزون كافٍ ✅',
      'No need': 'لا توجد حاجة للطلب',
    };

    replacements.forEach((key, value) {
      reason = reason.replaceAll(key, value);
    });

    return reason;
  }
}
