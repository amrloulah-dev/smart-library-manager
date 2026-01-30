import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;

class NetProfitCard extends StatelessWidget {
  final double netProfit;
  final double marginPercentage;

  const NetProfitCard({
    super.key,
    required this.netProfit,
    required this.marginPercentage,
  });

  @override
  Widget build(BuildContext context) {
    // Determine Color based on profit
    final bool isProfit = netProfit >= 0;
    final color = isProfit
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444); // Green or Red

    final absValue = netProfit.abs();
    final formattedValue = intl.NumberFormat(
      '#,##0.0',
      'en_US',
    ).format(absValue);
    // User Requirement: No negative sign, use specific icons.
    final text = '$formattedValue EGP';

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isProfit ? Icons.trending_up : Icons.trending_down,
                  color: color,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'صافي الربح',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Value Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: color,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              'هامش ربح صافي: ${marginPercentage.abs().toStringAsFixed(1)}%',
              style: TextStyle(
                color: color,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
