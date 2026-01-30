import 'package:flutter/material.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/sales/presentation/manager/relations_cubit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:librarymanager/features/sales/presentation/widgets/reservation_card.dart';

class ReservationsView extends StatelessWidget {
  const ReservationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: EdgeInsets.all(16.r),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E2439),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'بحث عن حجز، عميل، كتاب...',
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14.sp),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
              ),
              onChanged: (val) {
                // TODO: Implement local search filtering if needed
              },
            ),
          ),
        ),

        // Lists
        Expanded(
          child: StreamBuilder<List<Reservation>>(
            stream: context.read<RelationsCubit>().reservations,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CustomLoadingIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              final reservations = snapshot.data ?? [];

              if (reservations.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bookmark_border,
                        size: 64.sp,
                        color: Colors.grey[700],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'لا توجد حجوزات حالياً',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return AnimationLimiter(
                child: ListView.separated(
                  padding: EdgeInsets.only(
                    left: 16.r,
                    right: 16.r,
                    bottom: 100.h,
                  ), // Space for FAB
                  itemCount: reservations.length,
                  separatorBuilder: (context, index) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final reservation = reservations[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: ReservationCard(reservation: reservation),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
