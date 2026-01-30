import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:librarymanager/core/database/app_database.dart';

// -----------------------------------------------------------------------------
// 1. Sales Hero Card - Main Large Card
// -----------------------------------------------------------------------------
class SalesHeroCard extends StatelessWidget {
  final double totalSales;
  final double cashSales;
  final double creditSales;
  final double improvement;
  final String dateLabel;
  final VoidCallback onDateTap;

  const SalesHeroCard({
    super.key,
    required this.totalSales,
    required this.cashSales,
    required this.creditSales,
    required this.improvement,
    required this.dateLabel,
    required this.onDateTap,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate percentages for progress bar
    final total = cashSales + creditSales;
    final cashPct = total > 0 ? (cashSales / total) * 100 : 0.0;
    final creditPct = total > 0 ? (creditSales / total) * 100 : 0.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439), // Dark Slate
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Text(
            'إجمالي مبيعات اليوم',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16.sp,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: 12.h),

          // Big Value
          Text(
            '${totalSales.toStringAsFixed(0)} ج.م',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: 16.h),

          // Badges Row
          Row(
            children: [
              // Date Pill - Clickable
              InkWell(
                onTap: onDateTap,
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        dateLabel,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13.sp,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white70,
                        size: 16.sp,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.w),

              // Growth Pill
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: improvement >= 0
                      ? const Color(0xFF10B981).withOpacity(0.15)
                      : const Color(0xFFEF4444).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      improvement >= 0
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 16.sp,
                      color: improvement >= 0
                          ? const Color(0xFF10B981)
                          : const Color(0xFFEF4444),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${improvement.abs().toStringAsFixed(1)}%',
                      style: TextStyle(
                        color: improvement >= 0
                            ? const Color(0xFF10B981)
                            : const Color(0xFFEF4444),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Progress Section
          // Labels Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'آجل (${creditPct.toStringAsFixed(0)}%)',
                style: TextStyle(
                  color: const Color(0xFFFACC15), // Yellow/Amber
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Cairo',
                ),
              ),
              Text(
                'نقدي (${cashPct.toStringAsFixed(0)}%)',
                style: TextStyle(
                  color: const Color(0xFF3B82F6), // Electric Blue
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: SizedBox(
              height: 10.h,
              child: Row(
                children: [
                  // Cash Part (Blue) - Left
                  if (cashPct > 0)
                    Expanded(
                      flex: cashPct.toInt(),
                      child: Container(
                        color: const Color(0xFF3B82F6), // Electric Blue
                      ),
                    ),
                  if (cashPct > 0 && creditPct > 0) SizedBox(width: 2.w),
                  // Credit Part (Yellow) - Right
                  if (creditPct > 0)
                    Expanded(
                      flex: creditPct.toInt(),
                      child: Container(
                        color: const Color(0xFFFACC15), // Amber/Yellow
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 2. Breakdown Card - Square-ish Card
// -----------------------------------------------------------------------------
class BreakdownCard extends StatelessWidget {
  final String title;
  final double value;
  final IconData icon;
  final Color iconColor;

  const BreakdownCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 135.h,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1E2439), // Dark Slate
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon at Top
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 22.sp),
            ),
            const Spacer(),
            // Title
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12.sp,
                fontFamily: 'Cairo',
              ),
            ),
            SizedBox(height: 4.h),
            // Value (Bold)
            Text(
              '${value.toStringAsFixed(0)} ج.م',
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
  }
}

// -----------------------------------------------------------------------------
// 3. Transaction Tile
// -----------------------------------------------------------------------------
class TransactionTile extends StatelessWidget {
  final Sale sale;

  const TransactionTile({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    final isCash =
        sale.paymentType.toLowerCase().contains('cash') ||
        sale.paymentType.contains('نقدي');
    final timeStr = DateFormat('hh:mm a').format(sale.saleDate);

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439), // Dark Slate
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          // Leading: Icon Container
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: isCash
                  ? const Color(0xFFFACC15).withOpacity(0.15) // Yellow
                  : const Color(0xFF3B82F6).withOpacity(0.15), // Blue
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              Icons.receipt_long,
              color: isCash
                  ? const Color(0xFFFACC15) // Yellow
                  : const Color(0xFF3B82F6), // Blue
              size: 26.sp,
            ),
          ),
          SizedBox(width: 16.w),

          // Title & Subtitle Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'فاتورة #${sale.id.substring(0, 8)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  timeStr,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 13.sp,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),

          // Trailing: Amount & Type
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${sale.totalAmount.toStringAsFixed(0)} ج.م',
                style: TextStyle(
                  color: isCash
                      ? const Color(0xFFFACC15) // Yellow for Cash
                      : Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  Container(
                    width: 7.w,
                    height: 7.w,
                    decoration: BoxDecoration(
                      color: isCash
                          ? const Color(0xFF10B981) // Green for Cash
                          : const Color(0xFFF59E0B), // Orange for Credit
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    isCash ? 'نقدي' : 'آجل',
                    style: TextStyle(
                      color: isCash
                          ? const Color(0xFF10B981)
                          : const Color(0xFFF59E0B),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
