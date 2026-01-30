import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:librarymanager/features/reports/data/models/cash_flow_transaction.dart';
import 'package:librarymanager/features/reports/presentation/manager/cash_flow_cubit.dart';
import 'package:librarymanager/features/reports/presentation/widgets/custom_date_range_sheet.dart';

class CashFlowScreen extends StatelessWidget {
  const CashFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<CashFlowCubit>(),
      child: const _CashFlowView(),
    );
  }
}

class _CashFlowView extends StatelessWidget {
  const _CashFlowView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'تفاصيل حركة النقدية',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
            fontSize: 18.sp,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Time Filters
            const _TimeFilterSection(),
            SizedBox(height: 20.h),

            // Summary Card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: const _SummaryCard(),
            ),
            SizedBox(height: 20.h),

            // Transactions List
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 20.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2439),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: BlocBuilder<CashFlowCubit, CashFlowState>(
                  builder: (context, state) {
                    if (state is CashFlowLoading) {
                      return const Center(child: CustomLoadingIndicator());
                    } else if (state is CashFlowLoaded) {
                      if (state.transactions.isEmpty) {
                        return const Center(
                          child: Text(
                            'لا توجد عمليات في هذه الفترة',
                            style: TextStyle(color: Colors.white54),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: state.transactions.length,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        itemBuilder: (context, index) {
                          final transaction = state.transactions[index];
                          // Group logic could be added here (check if previous date diff is large)

                          return _TransactionItem(transaction: transaction);
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeFilterSection extends StatelessWidget {
  const _TimeFilterSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashFlowCubit, CashFlowState>(
      builder: (context, state) {
        CashFlowFilter active = CashFlowFilter.day;
        if (state is CashFlowLoaded) active = state.activeFilter;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFilterChip(context, 'يوم', CashFlowFilter.day, active),
            SizedBox(width: 8.w),
            _buildFilterChip(context, 'أسبوع', CashFlowFilter.week, active),
            SizedBox(width: 8.w),
            _buildFilterChip(context, 'شهر', CashFlowFilter.month, active),
            SizedBox(width: 8.w),
            _buildFilterChip(context, 'مخصص', CashFlowFilter.custom, active),
          ],
        );
      },
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    String label,
    CashFlowFilter filter,
    CashFlowFilter active,
  ) {
    final bool isActive = filter == active;
    return GestureDetector(
      onTap: () async {
        if (filter == CashFlowFilter.custom) {
          final List<DateTime?>? results = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const CustomDateRangeSheet(),
          );

          if (results != null && results.isNotEmpty) {
            final start = results.first!;
            final end = results.length > 1 ? results.last! : start;
            if (context.mounted) {
              context.read<CashFlowCubit>().fetchTransactions(
                CashFlowFilter.custom,
                customRange: DateTimeRange(start: start, end: end),
              );
            }
          }
        } else {
          context.read<CashFlowCubit>().fetchTransactions(filter);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20.r),
          border: isActive
              ? null
              : Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white60,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Cairo',
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashFlowCubit, CashFlowState>(
      builder: (context, state) {
        double net = 0;
        double income = 0;
        double expense = 0;

        if (state is CashFlowLoaded) {
          net = state.netBalance;
          income = state.totalIncome;
          expense = state.totalExpense;
        }

        return Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade900, const Color(0xFF1E2439)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'الرصيد الحالي',
                style: TextStyle(
                  color: Colors.white60,
                  fontFamily: 'Cairo',
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "${net >= 0 ? '+' : ''}${net.toStringAsFixed(0)} EGP",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cairo',
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryItem(
                      icon: Icons.arrow_downward,
                      label: 'دخل',
                      value: income,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                  Container(width: 1.w, height: 40.h, color: Colors.white10),
                  Expanded(
                    child: _buildSummaryItem(
                      icon: Icons.arrow_upward,
                      label: 'مصروف',
                      value: expense,
                      color: const Color(0xFFEF4444),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryItem({
    required IconData icon,
    required String label,
    required double value,
    required Color color,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 16.sp),
            SizedBox(width: 4.w),
            Text(
              label,
              style: TextStyle(color: Colors.white60, fontSize: 12.sp),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          value.toStringAsFixed(0),
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final CashFlowTransaction transaction;

  const _TransactionItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == TransactionType.income;
    final color = isIncome ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    final icon = isIncome
        ? Icons.account_balance_wallet
        : Icons.shopping_cart_outlined;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: color, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  "${DateFormat('hh:mm a').format(transaction.date)} • ${transaction.subtitle}",
                  style: TextStyle(color: Colors.white54, fontSize: 12.sp),
                ),
              ],
            ),
          ),
          Text(
            "${isIncome ? '+' : '-'}${transaction.amount.toStringAsFixed(0)}",
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
