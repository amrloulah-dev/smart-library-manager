import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:librarymanager/features/reports/presentation/manager/sales_details_cubit.dart';
import 'package:librarymanager/features/reports/presentation/pages/views/sales_report_view.dart';

/// Standalone Sales Details Screen
/// This wraps SalesReportView with a Scaffold and AppBar
/// Used when navigating directly to /sales_details route
class SalesDetailsScreen extends StatelessWidget {
  const SalesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Dark Navy Background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'تفاصيل المبيعات',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Menu action
            },
          ),
        ],
      ),
      body: BlocBuilder<SalesDetailsCubit, SalesDetailsState>(
        builder: (context, state) {
          // Reuse the SalesReportView for the body
          return const SalesReportView();
        },
      ),
    );
  }
}
