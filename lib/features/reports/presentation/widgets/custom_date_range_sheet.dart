import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:librarymanager/features/reports/presentation/widgets/managers/date_range_cubit.dart';

class CustomDateRangeSheet extends StatefulWidget {
  const CustomDateRangeSheet({super.key});

  @override
  State<CustomDateRangeSheet> createState() => _CustomDateRangeSheetState();
}

class _CustomDateRangeSheetState extends State<CustomDateRangeSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DateRangeCubit(),
      child: Builder(
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E2439),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
            ),
            child: SingleChildScrollView(
              child: BlocBuilder<DateRangeCubit, List<DateTime?>>(
                builder: (context, dates) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 8.h),
                      // Drag Handle
                      Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Header
                      Text(
                        'تحديد التاريخ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Date Display Row
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildDateDisplayBox(
                                label: 'إلى',
                                date: dates.length > 1 ? dates[1] : null,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: _buildDateDisplayBox(
                                label: 'من',
                                date: dates.isNotEmpty ? dates[0] : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Calendar
                      SizedBox(
                        height: 300.h,
                        child: CalendarDatePicker2(
                          config: CalendarDatePicker2Config(
                            calendarViewMode: CalendarDatePicker2Mode.day,
                            calendarType: CalendarDatePicker2Type.range,
                            selectedDayHighlightColor: const Color(
                              0xFF3B82F6,
                            ), // Electric Blue
                            weekdayLabelTextStyle: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                              fontSize: 12.sp,
                            ),
                            controlsTextStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Cairo',
                              fontSize: 14.sp,
                            ),
                            dayTextStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Cairo',
                              fontSize: 14.sp,
                            ),
                            disabledDayTextStyle: TextStyle(
                              color: Colors.white24,
                              fontFamily: 'Cairo',
                              fontSize: 14.sp,
                            ),
                            todayTextStyle: TextStyle(
                              color: const Color(0xFF3B82F6),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                              fontSize: 14.sp,
                            ),
                            yearTextStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Cairo',
                              fontSize: 14.sp,
                            ),
                          ),
                          value: dates,
                          onValueChanged: (newDates) {
                            context.read<DateRangeCubit>().updateDates(
                              newDates,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Apply Button
                      Padding(
                        padding: EdgeInsets.all(20.w),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () {
                              if (dates.isNotEmpty) {
                                Navigator.pop(context, dates);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3B82F6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Text(
                              'تطبيق',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateDisplayBox({required String label, DateTime? date}) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF111625),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12.sp,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            date != null ? DateFormat('dd MMMM').format(date) : '--',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }
}
