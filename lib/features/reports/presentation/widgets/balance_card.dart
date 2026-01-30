import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  final VoidCallback? onTap;

  const BalanceCard({super.key, required this.balance, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1E2439),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Percentage Badge (Left)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_upward,
                        color: Colors.green,
                        size: 12.sp,
                      ),
                    ],
                  ),
                ),

                // Title (Right)
                Row(
                  children: [
                    Text(
                      'حركة الدرج',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14.sp,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.receipt_long_rounded,
                        color: Colors.blue,
                        size: 16.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20.h),

            // Balance Value
            Center(
              child: Text(
                "${balance >= 0 ? '+' : ''}${balance.toStringAsFixed(0)} EGP",
                style: TextStyle(
                  color: balance >= 0 ? Colors.white : Colors.redAccent,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // Visual Bar Chart
            SizedBox(
              height: 60.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(7, (index) {
                  // Determine height and color
                  bool isToday = index == 6; // Last one is today
                  // Random-ish heights for visual effect
                  double height = [
                    20.h,
                    28.h,
                    16.h,
                    32.h,
                    24.h,
                    20.h,
                    40.h,
                  ][index];

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 8.w,
                        height: height,
                        decoration: BoxDecoration(
                          color: isToday
                              ? const Color(0xFF2563EB)
                              : Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      if (isToday) ...[
                        SizedBox(height: 4.h),
                        Text(
                          'اليوم',
                          style: TextStyle(
                            color: const Color(0xFF2563EB),
                            fontSize: 10.sp,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
