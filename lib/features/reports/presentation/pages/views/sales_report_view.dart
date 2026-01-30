import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:librarymanager/features/reports/presentation/manager/sales_details_cubit.dart';
import 'package:librarymanager/features/reports/presentation/widgets/sales_details_widgets.dart';
import 'package:librarymanager/features/reports/presentation/widgets/custom_date_range_sheet.dart';

/// Sales Report View - Used as a tab in ReportsScreen
/// Displays today's sales breakdown with cash/credit analysis
class SalesReportView extends StatelessWidget {
  const SalesReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesDetailsCubit, SalesDetailsState>(
      builder: (context, state) {
        if (state is SalesDetailsLoading) {
          return const Center(child: CustomLoadingIndicator());
        } else if (state is SalesDetailsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.red[400], size: 60.sp),
                SizedBox(height: 16.h),
                Text(
                  state.message,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.sp,
                    fontFamily: 'Cairo',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else if (state is SalesDetailsLoaded) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Sales Hero Card
                SalesHeroCard(
                  totalSales: state.totalDailySales,
                  cashSales: state.cashSales,
                  creditSales: state.creditSales,
                  improvement: state.dailyImprovement,
                  dateLabel: context.read<SalesDetailsCubit>().dateLabel,
                  onDateTap: () async {
                    final result = await showModalBottomSheet<List<DateTime?>>(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (_) => const CustomDateRangeSheet(),
                    );

                    if (result != null &&
                        result.isNotEmpty &&
                        result[0] != null) {
                      final start = result[0]!;
                      final end = result.length > 1 && result[1] != null
                          ? result[1]!
                          : start;

                      if (context.mounted) {
                        context.read<SalesDetailsCubit>().fetchSalesData(
                          range: DateTimeRange(start: start, end: end),
                        );
                      }
                    }
                  },
                ),
                SizedBox(height: 20.h),

                // 2. Row of 2 Breakdown Cards
                Row(
                  children: [
                    BreakdownCard(
                      title: 'مبيعات نقدية',
                      value: state.cashSales,
                      icon: Icons.payments_outlined,
                      iconColor: const Color(0xFF3B82F6), // Electric Blue
                    ),
                    SizedBox(width: 16.w),
                    BreakdownCard(
                      title: 'مبيعات آجلة',
                      value: state.creditSales,
                      icon: Icons.credit_card_outlined,
                      iconColor: const Color(0xFFFACC15), // Amber/Yellow
                    ),
                  ],
                ),
                SizedBox(height: 28.h),

                // 3. Section Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'آخر العمليات',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to full history
                      },
                      child: Text(
                        'عرض السجل',
                        style: TextStyle(
                          color: const Color(0xFFFACC15), // Yellow
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // 4. List of Transactions
                if (state.recentTransactions.isEmpty)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      child: Column(
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            color: Colors.white24,
                            size: 60.sp,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'لا توجد عمليات بيع حتى الآن',
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 15.sp,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.recentTransactions.length,
                    itemBuilder: (context, index) {
                      return TransactionTile(
                        sale: state.recentTransactions[index],
                      );
                    },
                  ),

                SizedBox(height: 40.h),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
