import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/reports/presentation/manager/ai_summary_cubit.dart';
import 'package:librarymanager/features/reports/domain/models/risk_analysis_result.dart'; // ✅ Added

/// Card Colors
const Color _deepNavy = Color(0xFF0F172A);
const Color _darkSlate = Color(0xFF1E2439);
const Color _greenAccent = Color(0xFF10B981);
const Color _blueAccent = Color(0xFF3B82F6);
const Color _goldAccent = Color(0xFFFFD700);
const Color _orangeAccent = Color(0xFFF97316);
const Color _redAccent = Color(0xFFEF4444);

/// AI Metric Card - For Inventory Health and Sales Forecast
class AiMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String badge;
  final IconData icon;
  final Color accentColor;

  const AiMetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.badge,
    required this.icon,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = badge.startsWith('+');

    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: _darkSlate,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: accentColor.withOpacity(0.3), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon and Badge Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon Circle
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(icon, color: accentColor, size: 22.sp),
                ),
                // Change Badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: (isPositive ? _greenAccent : _redAccent).withOpacity(
                      0.15,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                        color: isPositive ? _greenAccent : _redAccent,
                        size: 12.sp,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        badge,
                        style: TextStyle(
                          color: isPositive ? _greenAccent : _redAccent,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

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

            // Value - display directly as formatted by parent
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
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

/// Best Seller Card - For horizontal list
class BestSellerCard extends StatelessWidget {
  final BestSellerItem item;
  final int rank;

  const BestSellerCard({super.key, required this.item, required this.rank});

  Color get _rankColor {
    switch (rank) {
      case 1:
        return _goldAccent;
      case 2:
        return const Color(0xFFC0C0C0); // Silver
      case 3:
        return const Color(0xFFCD7F32); // Bronze
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      margin: EdgeInsets.only(left: 12.w),
      decoration: BoxDecoration(
        color: _darkSlate,
        borderRadius: BorderRadius.circular(16.r),
        border: rank == 1
            ? Border.all(color: _goldAccent.withOpacity(0.4), width: 1.5)
            : null,
      ),
      child: Stack(
        children: [
          // Content
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Book Image/Icon
                Container(
                  width: double.infinity,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: _deepNavy,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.menu_book_rounded,
                      color: _blueAccent.withOpacity(0.5),
                      size: 40.sp,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),

                // Book Title
                Text(
                  item.book.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),

                // Quantity Sold
                Text(
                  '${item.quantitySold} بيعت',
                  style: TextStyle(
                    color: _greenAccent,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),

          // Rank Badge (Top Right)
          Positioned(
            top: 8.w,
            right: 8.w,
            child: Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                color: _rankColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _rankColor.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '#$rank',
                  style: TextStyle(
                    color: rank <= 3 ? Colors.black : Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Dead Stock Card - For vertical list
class DeadStockCard extends StatelessWidget {
  final DeadStockItem item;
  final VoidCallback onActionTap;

  const DeadStockCard({
    super.key,
    required this.item,
    required this.onActionTap,
  });

  Color get _riskColor {
    switch (item.risk.level) {
      case RiskLevel.obsolete:
        return Colors.grey;
      case RiskLevel.earlyFailure:
      case RiskLevel.timeTrap:
        return _redAccent;
      case RiskLevel.coma:
        return _goldAccent;
      default:
        return _blueAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: _darkSlate,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _riskColor.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          // Book Image/Icon
          Container(
            width: 55.w,
            height: 70.h,
            decoration: BoxDecoration(
              color: _deepNavy,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Icon(
                Icons.warning_amber_rounded,
                color: _riskColor.withOpacity(0.8),
                size: 28.sp,
              ),
            ),
          ),
          SizedBox(width: 14.w),

          // Book Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.book.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  'الكمية: ${item.book.currentStock}',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 11.sp,
                    fontFamily: 'Cairo',
                  ),
                ),
                if (item.risk.suggestedReturnQty > 0)
                  Text(
                    'مرتجع مقترح: ${item.risk.suggestedReturnQty}',
                    style: TextStyle(
                      color: _redAccent,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 12.w),

          // Risk Badge & Action
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Risk Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: _riskColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: _riskColor, width: 1.5),
                ),
                child: Text(
                  item.risk.message,
                  style: TextStyle(
                    color: _riskColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 8.h),

              // Action Button
              GestureDetector(
                onTap: onActionTap,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: _riskColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    item.risk.action,
                    style: TextStyle(
                      color: Colors.black, // High contrast on bright colors
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Dead Stock Action Sheet
class DeadStockActionSheet extends StatelessWidget {
  final Book book;
  final VoidCallback onReturnTap;
  final VoidCallback onDiscountTap;

  const DeadStockActionSheet({
    super.key,
    required this.book,
    required this.onReturnTap,
    required this.onDiscountTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: _darkSlate,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),

          // Title
          Text(
            'اختر إجراء للكتاب',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: 8.h),

          // Book Name
          Text(
            book.name,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14.sp,
              fontFamily: 'Cairo',
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 24.h),

          // Option 1: Make Return
          _buildOptionTile(
            icon: Icons.assignment_return_outlined,
            color: _orangeAccent,
            title: 'تجهيز مرتجع',
            subtitle: 'إرجاع الكتاب للمورد',
            onTap: () {
              Navigator.pop(context);
              onReturnTap();
            },
          ),
          SizedBox(height: 12.h),

          // Option 2: Apply Discount
          _buildOptionTile(
            icon: Icons.discount_outlined,
            color: _greenAccent,
            title: 'عمل خصم',
            subtitle: 'تعديل سعر البيع',
            onTap: () {
              Navigator.pop(context);
              onDiscountTap();
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: _deepNavy,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Row(
          children: [
            // Icon Circle
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: color, size: 24.sp),
            ),
            SizedBox(width: 16.w),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12.sp,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            Icon(Icons.arrow_forward_ios, color: Colors.grey[600], size: 16.sp),
          ],
        ),
      ),
    );
  }
}
