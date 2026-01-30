import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/theme/app_theme.dart';
import 'package:librarymanager/features/operations/presentation/widgets/book_search_dialog.dart';
import 'package:librarymanager/features/sales/presentation/manager/relations_cubit.dart';

class ReservationCard extends StatelessWidget {
  final Reservation reservation;

  const ReservationCard({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RelationsCubit>();
    final isArrived = reservation.status == 'Arrived';
    final dateFormat = DateFormat('yyyy-MM-dd', 'ar');

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439), // Dark Slate
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Section
          Padding(
            padding: EdgeInsets.all(12.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Center(
                    child: Icon(Icons.menu_book_rounded, color: Colors.grey),
                  ),
                ),
                SizedBox(width: 12.w),

                // Center: Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reservation.bookName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 12.sp,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            dateFormat.format(reservation.createdAt),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 10.r,
                            backgroundColor: Colors.blueGrey,
                            child: Text(
                              reservation.customerName.characters.first
                                  .toUpperCase(),
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  reservation.customerName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  reservation.phone,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Left: Price Badge
                if (reservation.deposit > 0)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: const Color(0xFF3B82F6).withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      '${reservation.deposit} EGP',
                      style: TextStyle(
                        color: const Color(0xFF3B82F6),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Divider(color: Colors.white.withOpacity(0.05), height: 1),

          // Bottom Section: Action Buttons
          Padding(
            padding: EdgeInsets.all(12.r),
            child: Row(
              children: [
                // WhatsApp Button
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      final message = isArrived
                          ? 'مرحباً ${reservation.customerName}،  📚\nكتاب (${reservation.bookName}) وصل المكتبة وحجزك جاهز للاستلام.\nتنورنا في أي وقت! 🌹'
                          : 'مرحباً ${reservation.customerName}، شكراً لحجزك كتاب ${reservation.bookName}. سنخبرك عند وصوله.';
                      cubit.openWhatsAppWithMessage(reservation.phone, message);
                    },
                    icon: Icon(
                      Icons.chat_bubble_outline,
                      size: 16.sp,
                      color: AppTheme.emeraldGreen,
                    ), // Fallback for fa_whatsapp
                    label: Text(
                      'واتساب',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppTheme.emeraldGreen,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: AppTheme.emeraldGreen.withOpacity(0.3),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),

                // Call Button
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => cubit.makePhoneCall(reservation.phone),
                    icon: Icon(
                      Icons.phone,
                      size: 16.sp,
                      color: const Color(0xFF3B82F6),
                    ),
                    label: Text(
                      'اتصال',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF3B82F6),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: const Color(0xFF3B82F6).withOpacity(0.3),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),

                // Arrived / Sell Button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (!isArrived) {
                        cubit.updateReservationStatus(
                          reservation.id,
                          'Arrived',
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${reservation.bookName} وصل!'),
                            backgroundColor: AppTheme.emeraldGreen,
                          ),
                        );
                      } else {
                        if (reservation.bookId != null) {
                          final bookId = reservation.bookId;
                          final reservationId = reservation.id;

                          // Auto-remove reservation
                          context.read<RelationsCubit>().deleteReservation(
                            reservationId,
                          );

                          context.push(
                            '/pos',
                            extra: {
                              'bookId': bookId,
                              'reservationId': reservationId,
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (ctx) => BookSearchDialog(
                              title: 'ربط الحجز بكتاب',
                              onBookSelected: (book) async {
                                await context
                                    .read<RelationsCubit>()
                                    .linkBookToReservation(
                                      reservation.id,
                                      book.id,
                                    );
                                if (!context.mounted) return;
                                Navigator.pop(ctx);

                                // Auto-remove reservation
                                context
                                    .read<RelationsCubit>()
                                    .deleteReservation(reservation.id);

                                context.push(
                                  '/pos',
                                  extra: {
                                    'bookId': book.id,
                                    'reservationId': reservation.id,
                                  },
                                );
                              },
                            ),
                          );
                        }
                      }
                    },
                    icon: Icon(
                      isArrived
                          ? Icons.shopping_cart_checkout
                          : Icons.check_circle,
                      size: 16.sp,
                      color: Colors.white,
                    ),
                    label: Text(
                      isArrived ? 'بيع' : 'وصل',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isArrived
                          ? Colors.orange
                          : const Color(0xFF3B82F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
