import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:librarymanager/features/inventory/presentation/manager/inventory_cubit.dart';
import 'package:librarymanager/features/reports/presentation/manager/inventory_value_cubit.dart';
import 'package:librarymanager/features/reports/presentation/manager/inventory_value_state.dart';
import 'package:get_it/get_it.dart';
import 'package:librarymanager/core/utils/digit_format_extensions.dart';

class InventoryReportView extends StatefulWidget {
  const InventoryReportView({super.key});

  @override
  State<InventoryReportView> createState() => _InventoryReportViewState();
}

class _InventoryReportViewState extends State<InventoryReportView> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final cubit = context.read<InventoryCubit>();
      final state = cubit.state;
      if (state is InventoryLoaded) {
        if (!state.isLoadingMore && !state.hasReachedMax) {
          cubit.loadMoreBooks();
        }
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetIt.I<InventoryValueCubit>()..loadInventoryValue(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final cubit = context.read<InventoryCubit>();

          return Container(
            color: const Color(0xFF0F172A), // Deep Navy Background
            child: Column(
              children: [
                // Inventory Value Summary Card
                Padding(
                  padding: EdgeInsets.fromLTRB(16.r, 16.r, 16.r, 8.r),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF3B82F6).withOpacity(0.2),
                          const Color(0xFF06B6D4).withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: const Color(0xFF3B82F6).withOpacity(0.4),
                      ),
                    ),
                    child: BlocBuilder<InventoryValueCubit, InventoryValueState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12.r),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3B82F6).withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.inventory_2,
                                color: const Color(0xFF3B82F6),
                                size: 24.sp,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'إجمالي قيمة المخزون',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12.sp,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  if (state is InventoryValueLoading ||
                                      state is InventoryValueInitial)
                                    SizedBox(
                                      height: 20.h,
                                      width: 20.w,
                                      child: const CustomLoadingIndicator(
                                        size: 16,
                                      ),
                                    )
                                  else if (state is InventoryValueError)
                                    Text(
                                      'Error',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 14.sp,
                                      ),
                                    )
                                  else if (state is InventoryValueLoaded)
                                    Text(
                                      '${state.value.toEnglishAsFixed2} ر.س',
                                      style: TextStyle(
                                        color: const Color(0xFF3B82F6),
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Cairo',
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            // Refresh Button
                            IconButton(
                              onPressed: () {
                                context
                                    .read<InventoryValueCubit>()
                                    .loadInventoryValue();
                              },
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.white54,
                                size: 20.sp,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                // Search Bar
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.r,
                    vertical: 8.r,
                  ),
                  child: Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E2439), // Dark Slate Field
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) => cubit.updateSearch(value),
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'بحث عن كتاب...',
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14.sp,
                        ),
                        prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                      ),
                    ),
                  ),
                ),

                // Books List
                Expanded(
                  child: BlocBuilder<InventoryCubit, InventoryState>(
                    builder: (context, state) {
                      if (state is InventoryLoading ||
                          state is InventoryInitial) {
                        return const Center(child: CustomLoadingIndicator());
                      }

                      if (state is InventoryError) {
                        return Center(
                          child: Text(
                            'خطأ: ${state.message}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      if (state is InventoryLoaded) {
                        if (state.items.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.inventory_2_outlined,
                                  size: 64.sp,
                                  color: Colors.grey[700],
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  'لا توجد كتب',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.separated(
                          controller: _scrollController,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          itemCount: state.hasReachedMax
                              ? state.items.length
                              : state.items.length + 1,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            if (index >= state.items.length) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CustomLoadingIndicator(size: 24),
                                  ),
                                ),
                              );
                            }
                            final book = state.items[index];
                            return _BookListItem(book: book);
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BookListItem extends StatelessWidget {
  final Book book;

  const _BookListItem({required this.book});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final shouldRefresh = await context.push<bool>(
          '/item_history',
          extra: book,
        );
        if (shouldRefresh == true && context.mounted) {
          context.read<InventoryCubit>().loadBooks(isRefresh: true);
        }
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: const Color(0xFF1E2439),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.book_outlined,
                color: const Color(0xFF3B82F6),
                size: 24.sp,
              ),
            ),
            SizedBox(width: 12.w),

            // Book Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      _buildInfoChip(
                        'المخزون: ${book.currentStock.toEnglishString}',
                        book.currentStock < book.minLimit
                            ? Colors.red
                            : Colors.green,
                      ),
                      SizedBox(width: 8.w),
                      _buildInfoChip(
                        '${book.sellPrice.toEnglishAsFixed0} EGP',
                        Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Arrow
            Icon(Icons.arrow_forward_ios, color: Colors.grey[600], size: 16.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }
}
