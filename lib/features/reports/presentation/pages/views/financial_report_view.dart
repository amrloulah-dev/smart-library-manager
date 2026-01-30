import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:librarymanager/features/reports/domain/models/financial_report.dart';
import 'package:librarymanager/features/reports/presentation/manager/detailed_reports_cubit.dart';
import 'package:librarymanager/features/reports/presentation/widgets/report_cards.dart';
import 'package:librarymanager/features/reports/presentation/manager/financial_report_filter_cubit.dart';
import 'package:librarymanager/features/reports/presentation/widgets/custom_date_range_sheet.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:get_it/get_it.dart';

class FinancialReportView extends StatefulWidget {
  const FinancialReportView({super.key});

  @override
  State<FinancialReportView> createState() => _FinancialReportViewState();
}

class _FinancialReportViewState extends State<FinancialReportView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<FinancialReportFilterCubit>(),
      child:
          BlocListener<FinancialReportFilterCubit, FinancialReportFilterState>(
            listener: (context, state) {
              _updateReport(context, state);
            },
            child: Container(
              color: const Color(0xFF0F172A), // Deep Navy Background
              child: Column(
                children: [
                  _buildDateFilter(),
                  Expanded(
                    child:
                        BlocBuilder<DetailedReportsCubit, DetailedReportsState>(
                          builder: (context, state) {
                            if (state is DetailedReportsLoading) {
                              return const CustomLoadingIndicator();
                            } else if (state is DetailedReportsError) {
                              return Center(
                                child: Text(
                                  state.message,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              );
                            } else if (state is DetailedReportsLoaded) {
                              return _buildContent(state.financialReport);
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildDateFilter() {
    return BlocBuilder<FinancialReportFilterCubit, FinancialReportFilterState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.all(16.r),
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2439),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  // All Time Button
                  Expanded(
                    child: _buildToggleOption(
                      label: 'الكل', // All Time
                      isSelected: !state.isRangeMode,
                      onTap: () {
                        context.read<FinancialReportFilterCubit>().setRangeMode(
                          false,
                        );
                      },
                    ),
                  ),
                  // Custom Range Button
                  Expanded(
                    child: _buildToggleOption(
                      label: 'فترة مخصصة', // Custom Range
                      isSelected: state.isRangeMode,
                      onTap: () {
                        _pickDate(context); // Trigger picker immediately
                      },
                    ),
                  ),
                ],
              ),

              if (state.isRangeMode) ...[
                SizedBox(height: 12.h),
                // Date Picker Field (Only visible when Custom Mode is active)
                InkWell(
                  onTap: () => _pickDate(context),
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Colors.grey.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: const Color(0xFF3B82F6),
                          size: 20.sp,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            "${DateFormat('yyyy/MM/dd').format(state.selectedRange.start)} - ${DateFormat('yyyy/MM/dd').format(state.selectedRange.end)}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Cairo',
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // Clear Filter Icon
                        IconButton(
                          padding: EdgeInsets.zero, // Minimal padding
                          constraints: const BoxConstraints(), // Compact
                          icon: Icon(
                            Icons.close,
                            color: Colors.grey,
                            size: 20.sp,
                          ),
                          onPressed: () {
                            context
                                .read<FinancialReportFilterCubit>()
                                .setRangeMode(false);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              SizedBox(height: 8.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildToggleOption({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        margin: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3B82F6) : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
            fontFamily: 'Cairo', // Updated Font
          ),
        ),
      ),
    );
  }

  void _pickDate(BuildContext context) async {
    // Open Custom Sheet
    final result = await showModalBottomSheet<List<DateTime?>>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const CustomDateRangeSheet(),
    );

    if (result != null &&
        result.length == 2 &&
        result[0] != null &&
        result[1] != null &&
        context.mounted) {
      context.read<FinancialReportFilterCubit>().updateRange(
        DateTimeRange(start: result[0]!, end: result[1]!),
      );
    }
  }

  /* 
  // No longer using standard theme picker since we have a custom sheet
  Widget _themePicker(BuildContext context, Widget? child) { ... } 
  */

  Future<void> _updateReport(
    BuildContext context,
    FinancialReportFilterState state,
  ) async {
    final cubit = context.read<DetailedReportsCubit>();
    if (state.isRangeMode) {
      await cubit.fetchReport(state.selectedRange);
    } else {
      // Fetch All Time
      cubit.fetchAllTime();
    }
  }

  Widget _buildContent(FinancialReport report) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Sales Hero Card
          _SalesHeroCard(report: report),
          SizedBox(height: 16.h),

          // Stats Row (COGS & Expenses)
          _StatsRow(report: report),
          SizedBox(height: 16.h),

          // Net Profit
          _NetProfitCard(
            netProfit: report.netProfit,
            marginPercentage: report.totalRevenue > 0
                ? (report.netProfit / report.totalRevenue * 100)
                : 0.0,
          ),
          SizedBox(height: 24.h),

          // Top Profitable Items
          Text(
            'الأعلى ربحية',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: 16.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: report.topProfitableItems.length,
            itemBuilder: (context, index) {
              final item = report.topProfitableItems[index];
              return TopProfitableItemRow(
                rank: item.rank,
                name: item.name,
                value: 'ربح: ${item.profit.toStringAsFixed(1)} ج.م',
                performance: item.performance,
              );
            },
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}

class _SalesHeroCard extends StatelessWidget {
  final FinancialReport report;
  const _SalesHeroCard({required this.report});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439), // Dark Slate
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon + Title (Right in LTR, but UI implies RTL context often, let's follow visual: Right side has Icon+Title)
              // Actually, Flutter is usually LTR by default unless specified. Let's assume standard Row placement.
              // Logic: Right = End, Left = Start.
              // The user said: "Left: Small pill...", "Right: Icon...".
              // Assuming row children: [Left, Spacer, Right]
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'إجمالي الفواتير',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    'المبيعات',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.point_of_sale,
                    color: Colors.blueAccent,
                    size: 20.sp,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Big Value
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                NumberFormat('#,##0').format(report.totalRevenue),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                'ج.م',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14.sp,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Breakdown Row
          Row(
            children: [
              Expanded(
                child: _buildBreakdownCapsule(
                  label: 'كاش',
                  amount: report.totalSalesCash,
                  color: const Color(0xFF10B981), // Green
                  bg: const Color(0xFF10B981).withValues(alpha: 0.1),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildBreakdownCapsule(
                  label: 'آجل',
                  amount: report.totalSalesCredit,
                  color: const Color(0xFFF97316), // Orange
                  bg: const Color(0xFFF97316).withValues(alpha: 0.1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownCapsule({
    required String label,
    required double amount,
    required Color color,
    required Color bg,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 8.w),
          Text(
            '${NumberFormat.compact().format(amount)} $label',
            style: TextStyle(
              color: color,
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final FinancialReport report;
  const _StatsRow({required this.report});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cost of Goods Card
        Expanded(
          child: Container(
            height: 160.h, // Fixed height for alignment
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2439),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.inventory_2_outlined,
                    color: Colors.redAccent,
                    size: 20.sp,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'تكلفة المبيعات',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12.sp,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      NumberFormat('#,##0').format(report.totalCOGS),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    Text(
                      'تكلفة البضاعة المباعة',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 10.sp,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 16.w),

        // Expenses Card
        Expanded(
          child: GestureDetector(
            onTap: () => context.push('/cash_flow'),
            child: Container(
              height: 160.h,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2439),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: Colors.purpleAccent.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.attach_money,
                          color: Colors.purpleAccent,
                          size: 20.sp,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'تفاصيل',
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 10.sp,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.amber,
                            size: 10.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'المصروفات',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12.sp,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        NumberFormat('#,##0').format(report.totalExpenses),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NetProfitCard extends StatelessWidget {
  final double netProfit;
  final double marginPercentage;

  const _NetProfitCard({
    required this.netProfit,
    required this.marginPercentage,
  });

  @override
  Widget build(BuildContext context) {
    // Logic: If netProfit is 0 or greater, it's positive (Green).
    final isPositive = netProfit >= 0;

    // Colors
    final color = isPositive
        ? const Color(0xFF10B981) // Green
        : const Color(0xFFF43F5E); // Red

    final icon = isPositive ? Icons.arrow_upward : Icons.arrow_downward;

    final absValue = netProfit.abs();
    final formattedValue = NumberFormat('#,##0.0').format(absValue);
    final text = '$formattedValue ج.م';

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
                child: Icon(icon, color: color, size: 24.sp),
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
