import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:librarymanager/features/reports/domain/models/item_history_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class TimelineEventCard extends StatelessWidget {
  final ItemMovementEvent event;
  final bool isLast;

  const TimelineEventCard({
    super.key,
    required this.event,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Timeline Line & Node
          SizedBox(
            width: 50.w,
            child: Column(
              children: [
                // Icon Node
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2439),
                    shape: BoxShape.circle,
                    border: Border.all(color: _getColor(), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: _getColor().withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(_getIcon(), color: _getColor(), size: 16.sp),
                ),
                // Vertical Line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ),
              ],
            ),
          ),

          // 2. Event Card
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 24.h), // Spacing between events
              decoration: BoxDecoration(
                color: const Color(0xFF1E2439),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                children: [
                  // Content
                  Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat(
                                'yyyy/MM/dd hh:mm a',
                              ).format(event.date),
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12.sp,
                                fontFamily: 'Cairo', // Assuming consistent font
                              ),
                            ),
                            Text(
                              timeago.format(event.date, locale: 'ar'),
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 10.sp,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),

                        // Main Info
                        Row(
                          children: [
                            Text(
                              _getTitle(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: _getColor().withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                '${event.quantity}',
                                style: TextStyle(
                                  color: _getColor(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),

                        // Subtext (Price & Entity)
                        Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 14.sp,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                event.entityName,
                                style: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: 14.sp,
                                  fontFamily: 'Cairo',
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        if (event.referenceId != null) ...[
                          Row(
                            children: [
                              Icon(
                                Icons.numbers,
                                size: 14.sp,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'رقم مرجعي #${event.referenceId}',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12.sp,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Right Border Strip
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    width: 4.w,
                    child: Container(color: _getColor()),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor() {
    switch (event.type) {
      case InventoryEventType.purchase:
        return const Color(0xFF10B981); // Green
      case InventoryEventType.sale:
        return const Color(0xFFEF4444); // Red
      case InventoryEventType.supplierReturn:
      case InventoryEventType.customerReturn:
        return const Color(0xFFF59E0B); // Amber
    }
  }

  IconData _getIcon() {
    switch (event.type) {
      case InventoryEventType.purchase:
        return Icons.local_shipping_outlined;
      case InventoryEventType.sale:
        return Icons.shopping_cart_outlined;
      case InventoryEventType.supplierReturn:
        return Icons.assignment_return_outlined;
      case InventoryEventType.customerReturn:
        return Icons.keyboard_return;
    }
  }

  String _getTitle() {
    switch (event.type) {
      case InventoryEventType.purchase:
        return 'شراء';
      case InventoryEventType.sale:
        return 'بيع';
      case InventoryEventType.supplierReturn:
        return 'إرجاع لمورد';
      case InventoryEventType.customerReturn:
        return 'مرتجع من عميل';
    }
  }
}
