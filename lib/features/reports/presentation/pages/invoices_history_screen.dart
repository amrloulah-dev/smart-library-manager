import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:librarymanager/features/reports/domain/models/invoice_with_status.dart';
import 'package:librarymanager/features/reports/presentation/manager/invoices_history_cubit.dart';

class InvoicesHistoryScreen extends StatelessWidget {
  final Supplier supplier;

  const InvoicesHistoryScreen({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetIt.I<InvoicesHistoryCubit>()..loadInvoices(supplier.id),
      child: Scaffold(
        backgroundColor: const Color(0xFF0F172A), // Deep Navy
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'تاريخ الفواتير',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocBuilder<InvoicesHistoryCubit, InvoicesHistoryState>(
          builder: (context, state) {
            if (state is InvoicesHistoryLoading) {
              return const Center(child: CustomLoadingIndicator());
            } else if (state is InvoicesHistoryError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (state is InvoicesHistoryLoaded) {
              return _buildContent(context, state);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, InvoicesHistoryLoaded state) {
    return Column(
      children: [
        // Header Card
        Container(
          margin: EdgeInsets.all(16.w),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2439),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: const Color(0xFF2D3748),
                child: Text(
                  supplier.name.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      supplier.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'إجمالي المشتريات: ${state.totalPurchases.toStringAsFixed(0)} ج.م',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12.sp,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.bar_chart_rounded,
                color: const Color(0xFF3B82F6),
                size: 28.sp,
              ),
            ],
          ),
        ),

        // Filter Row
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(context, 'الكل', 'all', state.currentFilter),
                SizedBox(width: 8.w),
                _buildFilterChip(
                  context,
                  'غير مدفوع',
                  'unpaid',
                  state.currentFilter,
                ),
                SizedBox(width: 8.w),
                _buildFilterChip(
                  context,
                  'مدفوع جزئياً',
                  'partial',
                  state.currentFilter,
                ),
                SizedBox(width: 8.w),
                _buildFilterChip(
                  context,
                  'مكتمل',
                  'complete',
                  state.currentFilter,
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 16.h),

        // Invoices List
        Expanded(
          child: state.invoices.isEmpty
              ? Center(
                  child: Text(
                    'لا توجد فواتير',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.sp,
                      fontFamily: 'Cairo',
                    ),
                  ),
                )
              : ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: state.invoices.length,
                  separatorBuilder: (context, index) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    return _buildInvoiceCard(context, state.invoices[index]);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    String label,
    String value,
    String currentFilter,
  ) {
    final isSelected = currentFilter == value;
    return GestureDetector(
      onTap: () {
        context.read<InvoicesHistoryCubit>().applyFilter(supplier.id, value);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF1E2439),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF3B82F6) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[400],
            fontSize: 12.sp,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Cairo',
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceCard(
    BuildContext context,
    InvoiceWithStatus invoiceWithStatus,
  ) {
    final invoice = invoiceWithStatus.invoice;
    final status = invoiceWithStatus.status;

    // Status colors and icons
    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (status) {
      case InvoiceStatus.complete:
        statusColor = const Color(0xFF10B981); // Green
        statusIcon = Icons.check_circle;
        statusText = 'مكتمل';
        break;
      case InvoiceStatus.partial:
        statusColor = Colors.orange;
        statusIcon = Icons.pie_chart;
        statusText = 'مدفوع جزئياً';
        break;
      case InvoiceStatus.unpaid:
        statusColor = const Color(0xFFF97316); // Orange-Red
        statusIcon = Icons.access_time;
        statusText = 'غير مدفوع';
        break;
    }

    final dateFormat = DateFormat('yyyy-MM-dd', 'ar');

    return InkWell(
      onTap: () async {
        final shouldRefresh = await context.push<bool>(
          '/invoice_details',
          extra: invoice.id,
        );
        if (shouldRefresh == true && context.mounted) {
          context.read<InvoicesHistoryCubit>().loadInvoices(supplier.id);
        }
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1E2439),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            // Left: Status Icon
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: statusColor, width: 2),
              ),
              child: Icon(statusIcon, color: statusColor, size: 24.sp),
            ),

            SizedBox(width: 12.w),

            // Center: Invoice Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '#INV-${invoice.id.substring(0, 8)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    dateFormat.format(invoice.invoiceDate),
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12.sp,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),

            // Right: Amount & Badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${invoice.finalTotal.toStringAsFixed(0)} ج.م',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
