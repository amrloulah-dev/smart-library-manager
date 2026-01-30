import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:librarymanager/features/reports/presentation/manager/ai_summary_cubit.dart';
import 'package:librarymanager/features/reports/presentation/widgets/ai_summary_widgets.dart';

/// Design Colors
const Color _deepNavy = Color(0xFF0F172A);
const Color _darkSlate = Color(0xFF1E2439);
const Color _greenAccent = Color(0xFF10B981);
const Color _blueAccent = Color(0xFF3B82F6);
const Color _redAccent = Color(0xFFEF4444);

class AiSummaryScreen extends StatelessWidget {
  const AiSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _deepNavy,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'ملخص الذكاء الاصطناعي',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12.w),
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: _blueAccent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.auto_awesome, color: _blueAccent, size: 22.sp),
          ),
        ],
      ),
      body: BlocBuilder<AiSummaryCubit, AiSummaryState>(
        builder: (context, state) {
          if (state is AiSummaryLoading) {
            return const Center(child: CustomLoadingIndicator());
          }

          if (state is AiSummaryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: _redAccent, size: 48.sp),
                  SizedBox(height: 16.h),
                  Text(
                    'حدث خطأ في تحميل البيانات',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextButton(
                    onPressed: () =>
                        context.read<AiSummaryCubit>().loadAiSummary(),
                    child: Text(
                      'إعادة المحاولة',
                      style: TextStyle(
                        color: _blueAccent,
                        fontSize: 14.sp,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is AiSummaryLoaded) {
            return _buildContent(context, state.data);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, AiSummaryData data) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Row: Metric Cards
          Row(
            children: [
              // Inventory Health Card
              AiMetricCard(
                title: 'صحة المخزون',
                value: '${data.inventoryHealthScore.toStringAsFixed(1)}%',
                badge: '+${data.inventoryHealthChange.toStringAsFixed(0)}%',
                icon: Icons.inventory_2_outlined,
                accentColor: _greenAccent,
              ),
              SizedBox(width: 12.w),

              // Sales Forecast Card
              AiMetricCard(
                title: 'توقعات المبيعات',
                value: '${data.salesForecastScore.toStringAsFixed(1)}%',
                badge: '+${data.salesForecastChange.toStringAsFixed(0)}%',
                icon: Icons.trending_up_rounded,
                accentColor: _blueAccent,
              ),
            ],
          ),
          SizedBox(height: 28.h),

          // Best Sellers Section
          _buildSectionHeader(
            title: 'الأكثر مبيعاً',
            onViewAllTap: () {
              // Navigate to full best sellers list
            },
          ),
          SizedBox(height: 14.h),

          // Best Sellers Horizontal List
          if (data.bestSellers.isEmpty)
            _buildEmptyState('لا توجد بيانات مبيعات حتى الآن')
          else
            SizedBox(
              height: 185.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.bestSellers.length,
                padding: EdgeInsets.only(right: 4.w),
                itemBuilder: (context, index) {
                  return BestSellerCard(
                    item: data.bestSellers[index],
                    rank: index + 1,
                  );
                },
              ),
            ),
          SizedBox(height: 28.h),

          // Dead Stock Section
          _buildDeadStockHeader(data.deadStock.length),
          SizedBox(height: 8.h),

          // Dead Stock Subtitle
          Text(
            'لم يتم بيع أي نسخة من هذه الكتب منذ 30 يوماً',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12.sp,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: 14.h),

          // Dead Stock List
          if (data.deadStock.isEmpty)
            _buildEmptyState('لا توجد كتب راكدة - ممتاز!')
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.deadStock.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final item = data.deadStock[index];
                return DeadStockCard(
                  item: item,
                  onActionTap: () => _showDeadStockActions(context, item),
                );
              },
            ),
          SizedBox(height: 80.h), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    VoidCallback? onViewAllTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
        if (onViewAllTap != null)
          GestureDetector(
            onTap: onViewAllTap,
            child: Text(
              'عرض الكل',
              style: TextStyle(
                color: _blueAccent,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Cairo',
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDeadStockHeader(int count) {
    return Row(
      children: [
        Text(
          'الكتب الراكدة',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
        SizedBox(width: 10.w),
        if (count > 0)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: _redAccent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: _redAccent,
                  size: 14.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  'تنبيه المخزون',
                  style: TextStyle(
                    color: _redAccent,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: _darkSlate,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.check_circle_outline, color: _greenAccent, size: 40.sp),
            SizedBox(height: 12.h),
            Text(
              message,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14.sp,
                fontFamily: 'Cairo',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showDeadStockActions(BuildContext context, DeadStockItem item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DeadStockActionSheet(
        book: item.book,
        onReturnTap: () {
          // Navigate to Supplier Return screen
          context.push('/inventory/supplier_return');
        },
        onDiscountTap: () {
          // Navigate to Manual Edit (Book Edit)
          // For now, show a snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'سيتم الانتقال لتعديل سعر الكتاب',
                style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp),
              ),
              backgroundColor: _blueAccent,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          );
        },
      ),
    );
  }
}
