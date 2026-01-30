import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:librarymanager/features/reports/domain/models/supplier_stats.dart';
import 'package:librarymanager/features/reports/presentation/manager/supplier_details_cubit.dart';

class SupplierDetailsScreen extends StatelessWidget {
  final Supplier supplier;

  const SupplierDetailsScreen({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetIt.I<SupplierDetailsCubit>()..loadSupplierStats(supplier.id),
      child: Scaffold(
        backgroundColor: const Color(0xFF0F172A), // Deep Navy
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocBuilder<SupplierDetailsCubit, SupplierDetailsState>(
          builder: (context, state) {
            if (state is SupplierDetailsLoading) {
              return const Center(child: CustomLoadingIndicator());
            } else if (state is SupplierDetailsError) {
              return Center(
                child: Text(
                  'Err: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (state is SupplierDetailsLoaded) {
              return _buildContent(context, state.stats);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, SupplierStats stats) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header
                SizedBox(height: 10.h),
                CircleAvatar(
                  radius: 40.r,
                  backgroundColor: Colors.white,
                  child: Text(
                    supplier.name.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      color: const Color(0xFF0F172A),
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  supplier.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
                SizedBox(height: 24.h),

                // Stats Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatCard(
                      'إجمالي الديون',
                      '${stats.totalDebt.toStringAsFixed(0)} ج.م',
                      Colors.redAccent,
                      Icons.monetization_on_outlined,
                    ),
                    _buildStatCard(
                      'إجمالي المدفوع',
                      '${stats.totalPaid.toStringAsFixed(0)} ج.م',
                      Colors.greenAccent,
                      Icons.check_circle_outline,
                    ),
                    _buildStatCard(
                      'الرصيد الحالي',
                      '${stats.totalDebt.abs().toStringAsFixed(0)} ج.م',
                      stats.totalDebt > 0
                          ? Colors.orangeAccent
                          : Colors.blueAccent,
                      Icons.account_balance_wallet_outlined,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Info Row
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoCard(
                        Icons.location_on_outlined,
                        supplier.address ?? 'غير محدد',
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildInfoCard(
                        Icons.access_time,
                        "${supplier.leadTime ?? '-'} أيام توريد",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Activity Chart
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2439), // Dark Slate
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'حركة التعامل (أسبوعياً)',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      SizedBox(
                        height: 200.h,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY:
                                stats.weeklyActivity.reduce(
                                  (a, b) => a > b ? a : b,
                                ) *
                                1.2,
                            barTouchData: const BarTouchData(enabled: false),
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget:
                                      (double value, TitleMeta meta) {
                                        // Simple mock titles
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            top: 6,
                                          ),
                                          child: Text(
                                            'أسبوع ${value.toInt() + 1}',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10.sp,
                                              fontFamily: 'Cairo',
                                            ),
                                          ),
                                        );
                                      },
                                ),
                              ),
                              leftTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            gridData: const FlGridData(show: false),
                            borderData: FlBorderData(show: false),
                            barGroups: stats.weeklyActivity.reversed
                                .toList()
                                .asMap()
                                .entries
                                .map((e) {
                                  return BarChartGroupData(
                                    x: e.key,
                                    barRods: [
                                      BarChartRodData(
                                        toY: e.value,
                                        color: const Color(0xFF3B82F6),
                                        width: 12.w,
                                        borderRadius: BorderRadius.circular(
                                          4.r,
                                        ),
                                      ),
                                    ],
                                  );
                                })
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // AI Insight Card
                _buildAiInsightCard(stats),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),

        // Footer Card-Style Button
        Container(
          margin: EdgeInsets.all(16.w),
          child: InkWell(
            onTap: () {
              context.push('/invoices_history', extra: supplier);
            },
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Right: CircleAvatar with Icon
                  CircleAvatar(
                    radius: 24.r,
                    backgroundColor: const Color(0xFF60A5FA),
                    child: Icon(
                      Icons.receipt_long,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  // Center: Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'تاريخ الفواتير',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'عرض ${stats.invoiceCount} فاتورة سابقة',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 12.sp,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Left: Arrow Icon
                  Icon(Icons.arrow_back_ios, color: Colors.white, size: 20.sp),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      width: 100.w, // Fixed width or flex
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24.sp),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 10.sp,
              fontFamily: 'Cairo',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.grey, size: 20.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontFamily: 'Cairo',
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiInsightCard(SupplierStats stats) {
    final bool isWarning = stats.returnRate > 20.0;
    final color = isWarning ? Colors.redAccent : Colors.grey[300];
    final iconColor = isWarning ? Colors.redAccent : const Color(0xFFFFD700);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: iconColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.auto_awesome, color: iconColor, size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              stats.aiInsight,
              style: TextStyle(
                color: color,
                fontSize: 13.sp,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
