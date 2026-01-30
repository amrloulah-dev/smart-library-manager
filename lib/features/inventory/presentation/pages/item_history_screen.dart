import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:librarymanager/features/inventory/presentation/manager/item_history_cubit.dart';
import 'package:librarymanager/features/inventory/presentation/widgets/timeline_event_card.dart';
import 'package:librarymanager/features/reports/domain/models/item_history_model.dart';
import 'package:intl/intl.dart' as intl;
import 'package:timeago/timeago.dart' as timeago;

class ItemHistoryScreen extends StatefulWidget {
  final Book book;

  const ItemHistoryScreen({super.key, required this.book});

  @override
  State<ItemHistoryScreen> createState() => _ItemHistoryScreenState();
}

class _ItemHistoryScreenState extends State<ItemHistoryScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize Arabic locale for timeago
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    context.read<ItemHistoryCubit>().loadHistory(widget.book.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Deep Navy
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: BlocListener<ItemHistoryCubit, ItemHistoryState>(
                listener: (context, state) {
                  if (state is ItemHistoryDeleted) {
                    Navigator.of(
                      context,
                    ).pop(true); // Back to list with Refresh=true
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم حذف الكتاب بنجاح'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (state is ItemHistoryUpdated) {
                    Navigator.of(
                      context,
                    ).pop(true); // Back to list with Refresh=true
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم تحديث الكتاب بنجاح'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                child: BlocBuilder<ItemHistoryCubit, ItemHistoryState>(
                  builder: (context, state) {
                    if (state is ItemHistoryLoading) {
                      return const Center(child: CustomLoadingIndicator());
                    } else if (state is ItemHistoryError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (state is ItemHistoryLoaded) {
                      return ListView(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        children: [
                          SizedBox(height: 16.h),
                          _buildInsights(state.stats),
                          SizedBox(height: 24.h),
                          ...state.events.asMap().entries.map((entry) {
                            return TimelineEventCard(
                              event: entry.value,
                              isLast: entry.key == state.events.length - 1,
                            );
                          }),
                          SizedBox(height: 100.h), // Space for footer
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: BlocBuilder<ItemHistoryCubit, ItemHistoryState>(
        builder: (context, state) {
          if (state is ItemHistoryLoaded) {
            return _buildFooter(state.stats.totalProfit);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              Expanded(
                child: Container(
                  height: 45.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2439),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          widget.book.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontFamily: 'Cairo',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(Icons.close, color: Colors.grey, size: 18),
                    ],
                  ),
                ),
              ),
              // Actions
              IconButton(
                onPressed: () => _showEditDialog(context),
                icon: const Icon(Icons.edit, color: Colors.blue),
                tooltip: 'تعديل',
              ),
              IconButton(
                onPressed: () => _showDeleteConfirmation(context),
                icon: const Icon(Icons.delete, color: Colors.red),
                tooltip: 'حذف',
              ),
            ],
          ),
          SizedBox(height: 16.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'حركة الصنف: ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.sp,
                    fontFamily: 'Cairo',
                  ),
                ),
                TextSpan(
                  text: widget.book.name,
                  style: TextStyle(
                    color: const Color(0xFF3B82F6), // Blue
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    final cubit = context.read<ItemHistoryCubit>();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E2439),
        title: const Text('حذف الكتاب', style: TextStyle(color: Colors.white)),
        content: const Text(
          'هل أنت متأكد من حذف هذا الكتاب نهائيًا؟',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              // Trigger delete - listener will handle route pop after success
              cubit.deleteBook(widget.book.id);
              Navigator.pop(
                context,
              ); // Close dialog immediately to show loading/result on screen
            },
            child: const Text('حذف', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    final cubit = context.read<ItemHistoryCubit>();
    final nameController = TextEditingController(text: widget.book.name);
    final qtyController = TextEditingController(
      text: widget.book.currentStock.toString(),
    );
    final costController = TextEditingController(
      text: widget.book.costPrice.toString(),
    );
    final sellController = TextEditingController(
      text: widget.book.sellPrice.toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E2439),
        title: const Text(
          'تعديل الكتاب',
          style: TextStyle(color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField('اسم الكتاب', nameController),
              SizedBox(height: 8.h),
              _buildTextField('الكمية الحالية', qtyController, isNumber: true),
              SizedBox(height: 8.h),
              _buildTextField('سعر الشراء', costController, isNumber: true),
              SizedBox(height: 8.h),
              _buildTextField('سعر البيع', sellController, isNumber: true),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {
              final name = nameController.text.trim();
              final qty = int.tryParse(qtyController.text) ?? 0;
              final cost = double.tryParse(costController.text) ?? 0.0;
              final sell = double.tryParse(sellController.text) ?? 0.0;

              if (name.isNotEmpty) {
                cubit.updateBook(
                  id: widget.book.id,
                  name: name,
                  quantity: qty,
                  costPrice: cost,
                  sellPrice: sell,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('حفظ', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildInsights(ItemStats stats) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildInsightCard(
            icon: Icons.emoji_events_outlined,
            title: 'أفضل مورد',
            value: stats.bestSupplier == 'N/A'
                ? 'غير متوفر'
                : stats.bestSupplier,
            subValue: 'الأكثر توريداً',
            color: Colors.amber,
          ),
          SizedBox(width: 12.w),
          _buildInsightCard(
            icon: Icons.inventory_2_outlined,
            title: 'إجمالي التوريد',
            value:
                '${stats.supplierBreakdown.values.fold(0, (sum, val) => sum + val)} نسخة',
            subValue: stats.supplierBreakdown.entries
                .take(2)
                .map((e) => '${e.value} ${e.key}')
                .join(', '),
            color: Colors.blue,
          ),
          SizedBox(width: 12.w),
          _buildInsightCard(
            icon: Icons.speed,
            title: 'معدل الدوران',
            value: stats.avgTurnoverDays > 0
                ? 'بيع كل ${stats.avgTurnoverDays.toStringAsFixed(1)} يوم'
                : 'بيانات محدودة',
            subValue: 'حساب سرعة المبيعات',
            color: Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard({
    required IconData icon,
    required String title,
    required String value,
    required String subValue,
    required Color color,
  }) {
    return Container(
      width: 160.w,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20.sp),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10.sp,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.h),
          Text(
            subValue,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 9.sp,
              fontFamily: 'Cairo',
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(double profit) {
    return Container(
      color: const Color(0xFF0F172A),
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: const Color(0xFF3B82F6), // Blue
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3B82F6).withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'صافي الربح الشهري للكتاب:',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14.sp,
                fontFamily: 'Cairo',
              ),
            ),
            Text(
              '${intl.NumberFormat('#,##0.0').format(profit)} ر.س',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
