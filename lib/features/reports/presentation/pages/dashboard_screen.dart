import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:librarymanager/core/constants/app_strings.dart';
import 'package:librarymanager/core/theme/app_colors.dart';
import 'package:librarymanager/core/theme/app_theme.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:librarymanager/features/reports/presentation/manager/dashboard_cubit.dart';
import 'package:librarymanager/features/reports/presentation/widgets/balance_card.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:librarymanager/features/reports/presentation/widgets/dashboard_header.dart';
import 'package:librarymanager/features/reports/domain/repositories/reports_repository.dart';
import 'package:librarymanager/features/reports/presentation/widgets/dashboard_stat_card.dart';
import 'package:librarymanager/core/services/supabase_sync_service.dart';

import 'package:librarymanager/features/operations/presentation/manager/expenses_cubit.dart';
import 'package:librarymanager/features/operations/presentation/widgets/add_expense_sheet.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<DashboardCubit>()..loadDashboardStats(),
      child: const _DashboardScreenContent(),
    );
  }
}

class _DashboardScreenContent extends StatelessWidget {
  const _DashboardScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      floatingActionButton: SizedBox(
        width: 65.w,
        height: 65.w,
        child: FloatingActionButton(
          heroTag: 'dashboard_fab',
          onPressed: () async {
            await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => BlocProvider(
                create: (context) => GetIt.I<ExpensesCubit>(),
                child: const AddExpenseSheet(),
              ),
            );
            if (context.mounted) {
              context.read<DashboardCubit>().loadDashboardStats();
            }
          },
          backgroundColor: AppColors.error,
          shape: const CircleBorder(),
          child: Icon(Icons.remove, color: AppColors.textPrimary, size: 32.sp),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(child: CustomLoadingIndicator());
            }

            if (state is DashboardError) {
              return Center(
                child: Text(
                  '${AppStrings.error}: ${state.message}',
                  style: const TextStyle(color: AppColors.textPrimary),
                ),
              );
            }

            if (state is DashboardLoaded) {
              final stats = state.stats;
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const DashboardHeader(),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => _onRestorePressed(context),
                              tooltip: 'استعادة البيانات من السحابة',
                              icon: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.overlayLight,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.cloud_download_outlined,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            IconButton(
                              onPressed: () => context.push('/smart_settings'),
                              icon: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.overlayLight,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.settings_suggest,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Top Stats Grid
                    Builder(
                      builder: (context) {
                        final statItems = [
                          _StatItem(
                            title: AppStrings.sales,
                            value:
                                '${stats.salesToday.toStringAsFixed(0)} ${AppStrings.egp}',
                            icon: Icons.attach_money,
                            color: AppColors.success,
                            onTap: () async {
                              await context.push('/sales_details');
                              if (context.mounted) {
                                context
                                    .read<DashboardCubit>()
                                    .loadDashboardStats();
                              }
                            },
                          ),
                          _StatItem(
                            title: 'كتب مباعة',
                            value: '${stats.booksSoldToday}',
                            icon: Icons.menu_book_rounded,
                            color: const Color(0xFF8E44AD), // Purple
                            onTap: () async {
                              await context.push('/sales_details');
                              if (context.mounted) {
                                context
                                    .read<DashboardCubit>()
                                    .loadDashboardStats();
                              }
                            },
                          ),
                          _StatItem(
                            title: AppStrings.shortages,
                            value: '${stats.lowStockCount}',
                            icon: Icons.warning_amber_rounded,
                            color: AppColors.secondary,
                            onTap: () async {
                              await context.push('/shortages');
                              if (context.mounted) {
                                context
                                    .read<DashboardCubit>()
                                    .loadDashboardStats();
                              }
                            },
                          ),
                          _StatItem(
                            title: AppStrings.returns,
                            value: '${stats.returnsCount}',
                            icon: Icons.assignment_return_outlined,
                            color: AppColors.error,
                            onTap: () async {
                              await context.push('/risky_books');
                              if (context.mounted) {
                                context
                                    .read<DashboardCubit>()
                                    .loadDashboardStats();
                              }
                            },
                          ),
                        ];

                        final width = MediaQuery.sizeOf(context).width;
                        int crossAxisCount = width < 600
                            ? 2
                            : (width < 900 ? 3 : 4);
                        // Adjust aspect ratio for better card fitting
                        double aspectRatio = width < 600
                            ? 1.4
                            : (width < 900 ? 1.2 : 1.3);

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 12.w,
                                mainAxisSpacing: 12.h,
                                childAspectRatio: aspectRatio,
                              ),
                          itemCount: statItems.length,
                          itemBuilder: (context, index) {
                            final item = statItems[index];
                            return DashboardStatCard(
                              title: item.title,
                              value: item.value,
                              icon: item.icon,
                              color: item.color,
                              onTap: item.onTap,
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: 24.h),

                    // Main Balance Card
                    BalanceCard(
                      balance: stats.cashInDrawer,
                      onTap: () => context.push('/cash_flow'),
                    ),
                    SizedBox(height: 24.h),

                    // AI Insights
                    _buildAiInsightsCard(context, stats),
                    SizedBox(height: 24.h),

                    // Recent Operations Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.recentOperations,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppTheme.fontFamily,
                          ),
                        ),
                        Text(
                          AppStrings.viewAll,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppTheme.fontFamily,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // List of Operations
                    _buildRecentOperationsList(stats.recentSales),
                    SizedBox(height: 80.h), // Space for FAB
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildAiInsightsCard(BuildContext context, DashboardStats stats) {
    final color = stats.isPositiveInsight ? AppColors.success : AppColors.error;

    return GestureDetector(
      onTap: () => context.push('/ai_summary'),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: const Icon(
                Icons.psychology,
                color: AppColors.textPrimary,
                size: 20,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.aiAnalysis,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppTheme.fontFamily,
                    ),
                  ),
                  Text(
                    stats.aiInsight,
                    style: TextStyle(
                      color: AppColors.textPrimary.withOpacity(0.7),
                      fontSize: 12.sp,
                      fontFamily: AppTheme.fontFamily,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textSecondary,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentOperationsList(List<Sale> sales) {
    if (sales.isEmpty) {
      return Container(
        height: 150.h,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.assignment_outlined,
                color: AppColors.textSecondary.withOpacity(0.5),
                size: 40.sp,
              ),
              SizedBox(height: 12.h),
              Text(
                'لا توجد عمليات حديثة',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14.sp,
                  fontFamily: AppTheme.fontFamily,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sales.length,
      separatorBuilder: (c, i) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final sale = sales[index];
        final timeStr = timeago.format(sale.saleDate, locale: 'ar');

        return Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.overlayLight,
                child: Icon(
                  Icons.shopping_bag_outlined,
                  color: AppColors.textSecondary,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AppStrings.saleOperation} #${sale.id.substring(sale.id.length > 5 ? sale.id.length - 5 : 0)}',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppTheme.fontFamily,
                    ),
                  ),
                  Text(
                    timeStr,
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12.sp,
                      fontFamily: AppTheme.fontFamily,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '+ ${sale.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: AppColors.successLight,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppTheme.fontFamily,
                    ),
                  ),
                  Text(
                    sale.paymentType == 'Cash' ? 'نقدي' : 'آجل',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 10.sp,
                      fontFamily: AppTheme.fontFamily,
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

  void _onRestorePressed(BuildContext context) async {
    // 1. Confirm Dialog (Keep existing logic)
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('استعادة البيانات'),
        content: const Text(
          'سيتم تحميل النسخة الاحتياطية من السحابة. هل أنت متأكد؟',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );

    if (confirm != true) return;
    if (!context.mounted) return;

    // 2. Show Loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const PopScope(
        canPop: false, // User cannot back out manually
        child: Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('جاري استعادة البيانات...'),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    try {
      // 3. Execute Restore
      await GetIt.I<SupabaseSyncService>().restoreData();

      // Success Message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تمت العملية بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
        context.read<DashboardCubit>().loadDashboardStats(); // Refresh UI
      }
    } catch (e) {
      // Error Message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('اكتمل مع وجود ملاحظات: $e'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } finally {
      // 4. THE FIX: FORCE CLOSE DIALOG
      // This block runs NO MATTER WHAT happens above.
      if (context.mounted) {
        // Use rootNavigator: true to ensure we pop the Dialog, not the Screen
        Navigator.of(context, rootNavigator: true).pop();
      }
    }
  }
}

class _StatItem {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  _StatItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}
