import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:librarymanager/features/reports/presentation/manager/suppliers_report_cubit.dart';
import 'package:librarymanager/features/reports/presentation/widgets/supplier_report_card.dart';

class SuppliersReportView extends StatelessWidget {
  const SuppliersReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetIt.I<SuppliersReportCubit>()..loadSuppliersReport(),
      child: Scaffold(
        backgroundColor: const Color(0xFF0F172A), // Deep Navy
        body: BlocBuilder<SuppliersReportCubit, SuppliersReportState>(
          builder: (context, state) {
            if (state is SuppliersReportLoading) {
              return const Center(child: CustomLoadingIndicator());
            } else if (state is SuppliersReportError) {
              return Center(
                child: Text(
                  'Err: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (state is SuppliersReportLoaded) {
              return _buildContent(context, state);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, SuppliersReportLoaded state) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                // Top Row: 2 Big Cards
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        'إجمالي المدفوع',
                        '${state.totalPaidToSuppliers.toStringAsFixed(0)} ج.م',
                        const Color(0xFF10B981), // Green
                        Icons.check_circle_outline,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildSummaryCard(
                        'إجمالي الديون',
                        '${state.totalDebt.toStringAsFixed(0)} ج.م',
                        Colors.redAccent,
                        Icons.attach_money,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                // List Title + Count Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.end, // RTL
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        '${state.suppliers.length} مورد',
                        style: TextStyle(
                          color: const Color(0xFF3B82F6),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'قائمة الموردين',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),
        ),
        // List
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return SupplierReportCard(model: state.suppliers[index]);
          }, childCount: state.suppliers.length),
        ),
        SliverPadding(padding: EdgeInsets.only(bottom: 24.h)),
      ],
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    Color accentColor,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439), // Dark Slate
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: accentColor.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end, // Right align for RTL
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: accentColor, size: 24.sp),
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14.sp,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp, // Slightly larger
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }
}
