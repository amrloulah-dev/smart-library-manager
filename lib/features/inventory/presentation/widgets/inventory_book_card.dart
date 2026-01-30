import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/theme/app_theme.dart';
import 'package:get_it/get_it.dart';
import 'package:librarymanager/features/reports/domain/services/business_intelligence_service.dart';

class InventoryBookCard extends StatelessWidget {
  final Book book;

  const InventoryBookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final bool isReserved = book.reservedQuantity > 0;
    // Use Smart AI Logic for shortage (Low Stock)
    final biService = GetIt.I<BusinessIntelligenceService>();
    final bool isLowStock = biService.isShortage(book);

    // Status Badge Logic
    String statusText = 'متوفر';
    Color statusColor = const Color(0xFF10B981); // Green
    Color statusBg = const Color(0xFF10B981).withOpacity(0.1);

    if (isReserved) {
      statusText = 'محجوز';
      statusColor = Colors.purpleAccent;
      statusBg = Colors.purple.withOpacity(0.2);
    } else if (isLowStock) {
      statusText = 'مخزون منخفض';
      statusColor = AppTheme.secondaryOrange;
      statusBg = AppTheme.secondaryOrange.withOpacity(0.1);
    } else if (book.currentStock == 0) {
      statusText = 'نفذت الكمية';
      statusColor = AppTheme.roseRed;
      statusBg = AppTheme.roseRed.withOpacity(0.1);
    }

    return Card(
      color: const Color(0xFF1E2439), // Dark Slate
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      elevation: 0,
      margin: EdgeInsets.zero, // Margin handled by Grid spacing
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section (Book Cover)
            _buildBookCover(isReserved),

            SizedBox(width: 12.w),

            // Info Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top: Status Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: statusBg,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          statusText,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Middle: Title & Author (Flexible to prevent overflow)
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            book.name,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.1,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (book.publisher != null) ...[
                          SizedBox(height: 2.h),
                          Text(
                            book.publisher!,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.grey[400],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Bottom: Price & Quantity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Price
                      Text(
                        '${book.sellPrice.toInt()} ج.م',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B82F6), // Electric Blue
                        ),
                      ),

                      // Quantity Column
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'الكمية',
                            style: TextStyle(
                              fontSize: 9.sp,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '${book.currentStock}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookCover(bool isReserved) {
    return Stack(
      children: [
        Container(
          width: 60.w, // Reduced width
          height: 85.h, // Reduced height to fit better in grid
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A), // Dark Navy placeholder
            borderRadius: BorderRadius.circular(8.r),
            gradient: const LinearGradient(
              colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.menu_book_rounded,
              color: Colors.white.withOpacity(0.1),
              size: 32.sp,
            ),
          ),
        ),
        // Overlay if Reserved
        if (isReserved)
          Container(
            width: 60.w,
            height: 85.h,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Icon(
                Icons.lock_rounded,
                color: Colors.white.withOpacity(0.9),
                size: 24.sp,
              ),
            ),
          ),
      ],
    );
  }
}
