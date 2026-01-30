import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:librarymanager/features/reports/presentation/manager/detailed_reports_cubit.dart';
import 'package:librarymanager/features/reports/presentation/manager/sales_details_cubit.dart';
import 'package:librarymanager/features/inventory/presentation/manager/inventory_cubit.dart';
import 'package:librarymanager/features/reports/presentation/pages/views/financial_report_view.dart';
import 'package:librarymanager/features/reports/presentation/pages/views/inventory_report_view.dart';
import 'package:librarymanager/features/reports/presentation/pages/views/sales_report_view.dart';
import 'package:librarymanager/features/reports/presentation/pages/views/suppliers_report_view.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<DetailedReportsCubit>()..fetchAllTime(),
      child: const _ReportsScreenContent(),
    );
  }
}

class _ReportsScreenContent extends StatelessWidget {
  const _ReportsScreenContent();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFF11141D), // Dark background
        appBar: AppBar(
          title: const Text(
            'Reports & Analytics',
            style: TextStyle(
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              height: 50.h,
              decoration: BoxDecoration(
                color: const Color(0xFF1E2439), // Dark Navy
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: const Color(0xFF3B82F6), // Electric Blue
                  borderRadius: BorderRadius.circular(25.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3B82F6).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                dividerColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                labelStyle: TextStyle(
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
                tabs: const [
                  Tab(text: 'المالي'),
                  Tab(text: 'المخزون'),
                  Tab(text: 'المبيعات'),
                  Tab(text: 'الموردين'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          physics:
              const NeverScrollableScrollPhysics(), // Disable swipe if needed, or keep helpful
          children: [
            const FinancialReportView(),
            BlocProvider.value(
              value: GetIt.I<InventoryCubit>()..loadBooks(isRefresh: true),
              child: const InventoryReportView(),
            ),
            // Sales Report Tab
            BlocProvider(
              create: (context) =>
                  GetIt.I<SalesDetailsCubit>()..fetchSalesData(),
              child: const SalesReportView(),
            ),
            const SuppliersReportView(),
          ],
        ),
      ),
    );
  }
}
