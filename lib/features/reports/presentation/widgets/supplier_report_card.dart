import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:librarymanager/features/reports/domain/models/supplier_report_model.dart';
import 'package:go_router/go_router.dart';

class SupplierReportCard extends StatelessWidget {
  final SupplierReportModel model;

  const SupplierReportCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final supplier = model.supplier;
    final aiScore = supplier.aiScore ?? 5.0;

    // Determine status strip color
    Color statusColor;
    if (aiScore < 3.0) {
      statusColor = Colors.redAccent;
    } else if (aiScore >= 4.0) {
      statusColor = const Color(0xFF10B981); // Green
    } else {
      statusColor = Colors.grey;
    }

    // Determine balance color/text
    final isDept = supplier.balance > 0;
    final balanceColor = isDept ? Colors.redAccent : const Color(0xFF10B981);
    final balanceText = isDept ? 'مستحق' : 'رصيد لنا';

    final dateFormat = DateFormat('yyyy-MM-dd', 'ar');

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: InkWell(
        onTap: () {
          context.push('/supplier_details', extra: supplier);
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Column(
          children: [
            Container(
              height: 90.h,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: const Color(0xFF1E2439), // Dark Slate
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Left Status Bar
                  Container(width: 6.w, color: statusColor),
                  SizedBox(width: 12.w),

                  // Content
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Left: Balance Info (Left side visually but first in Row if LTR, wait.. design says RTL usually for Arabic)
                          // The user description: "Left (Balance)", "Right (Avatar)".
                          // Assuming Row children order: Balance -> Spacer -> Info -> Avatar (if Directionality is LTR).
                          // Since app seems Arabic predominantly, keep RTL mind-set, but Flutter Row is LTR by default unless context is RTL.
                          // I will assume LTR build order: Balance -> ...Info... -> Avatar

                          // Balance Section
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${supplier.balance.abs().toStringAsFixed(0)} ج.م',
                                style: TextStyle(
                                  color: balanceColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                              Text(
                                balanceText,
                                style: TextStyle(
                                  color: balanceColor.withOpacity(0.8),
                                  fontSize: 12.sp,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),

                          // Middle: Info
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                supplier.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                ),
                                textAlign: TextAlign.right,
                              ),
                              SizedBox(height: 4.h),
                              // AI Score Stars
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '(${aiScore.toStringAsFixed(1)} ${_getScoreLabel(aiScore)})',
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 10.sp,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  ...List.generate(5, (index) {
                                    if (index < aiScore.floor()) {
                                      return Icon(
                                        Icons.star_rounded,
                                        color: const Color(0xFFFFD700),
                                        size: 14.sp,
                                      );
                                    } else if (index < aiScore &&
                                        (aiScore - index) >= 0.5) {
                                      return Icon(
                                        Icons.star_half_rounded,
                                        color: const Color(0xFFFFD700),
                                        size: 14.sp,
                                      );
                                    } else {
                                      return Icon(
                                        Icons.star_outline_rounded,
                                        color: Colors.grey[700],
                                        size: 14.sp,
                                      );
                                    }
                                  }),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'آخر توريد: ${dateFormat.format(supplier.lastUpdated)}',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10.sp,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ],
                          ),

                          SizedBox(width: 12.w),

                          // Right: Avatar
                          CircleAvatar(
                            radius: 26.r,
                            backgroundColor: const Color(0xFF2D3748),
                            child: Text(
                              supplier.name.isNotEmpty
                                  ? supplier.name.substring(0, 1).toUpperCase()
                                  : '?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Conditional AI Bubble
            if (model.insightType != InsightType.none) ...[
              SizedBox(height: 4.h), // Small gap
              _buildAiBubble(model),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAiBubble(SupplierReportModel model) {
    Color bubbleColor;
    Color textColor;
    IconData icon;

    if (model.insightType == InsightType.positive) {
      bubbleColor = const Color(
        0xFF10B981,
      ).withOpacity(0.15); // Dark Green tint
      textColor = const Color(0xFF10B981);
      icon = Icons.verified;
    } else {
      bubbleColor = Colors.redAccent.withOpacity(0.15);
      textColor = Colors.redAccent;
      icon = Icons.warning_rounded;
    }

    return Column(
      children: [
        // Little Triangle pointing up
        // Align it with the status bar or center? Design says "below the card".
        // Let's put a small arrow centered or slightly to the right to match the "insight" logic.
        // Let's align it with center for now.
        // Or align with the Info section.
        // Let's keep it simple: just a bubble close to the card.
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.r),
              bottomRight: Radius.circular(12.r),
              topLeft: Radius.circular(4.r),
              topRight: Radius.circular(4.r),
            ),
            border: Border.all(color: textColor.withOpacity(0.3), width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  model.insightMessage ?? '',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 11.sp,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(icon, color: textColor, size: 16.sp),
              SizedBox(width: 4.w),
              Text(
                ':AI تحليل',
                style: TextStyle(
                  color: textColor,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getScoreLabel(double score) {
    if (score >= 4.5) return 'ممتاز';
    if (score >= 4.0) return 'جيد جدا';
    if (score >= 3.0) return 'جيد';
    if (score >= 2.0) return 'ضعيف';
    return 'سيئ';
  }
}
