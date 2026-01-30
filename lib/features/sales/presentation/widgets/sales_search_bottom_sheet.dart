import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:librarymanager/core/constants/book_constants.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:librarymanager/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:librarymanager/features/sales/presentation/manager/sales_cubit.dart';
import 'package:librarymanager/features/sales/presentation/widgets/filter_dropdown.dart';
import 'package:librarymanager/features/sales/presentation/widgets/unknown_item_dialog.dart';
import 'package:librarymanager/features/sales/presentation/widgets/managers/sales_search_cubit.dart';
import 'package:librarymanager/features/sales/presentation/widgets/managers/sales_search_state.dart';

class SalesSearchBottomSheet extends StatefulWidget {
  final Function(Book)? onBookSelected;

  const SalesSearchBottomSheet({super.key, this.onBookSelected});

  @override
  State<SalesSearchBottomSheet> createState() => _SalesSearchBottomSheetState();
}

class _SalesSearchBottomSheetState extends State<SalesSearchBottomSheet> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SalesSearchCubit(GetIt.I<InventoryRepository>()),
      child: BlocBuilder<SalesSearchCubit, SalesSearchState>(
        builder: (context, state) {
          final cubit = context.read<SalesSearchCubit>();

          return DraggableScrollableSheet(
            initialChildSize: 0.9,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2439),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24.r),
                  ),
                ),
                child: Column(
                  children: [
                    // Header
                    _buildHeader(context),

                    // Search Bar
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF111625),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: cubit.updateQuery,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                          decoration: InputDecoration(
                            hintText: 'ابحث باسم الكتاب، الناشر...',
                            hintStyle: TextStyle(
                              color: Colors.white30,
                              fontSize: 14.sp,
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Filters Row
                    _buildFilterRow(context, state, cubit),

                    // Results Count
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 8.h,
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${state.results.length} نتيجة',
                            style: TextStyle(
                              color: const Color(0xFF3B82F6), // Electric Blue
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Results List
                    Expanded(
                      child: state.isLoading
                          ? const Center(child: CustomLoadingIndicator())
                          : state.results.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.menu_book,
                                    size: 60.sp,
                                    color: Colors.white10,
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    'لم يتم العثور على كتب',
                                    style: TextStyle(
                                      color: Colors.white30,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  SizedBox(height: 24.h),
                                  // Add Manual Item Button
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      final salesCubit = context
                                          .read<SalesCubit>();
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (_) => BlocProvider.value(
                                          value: salesCubit,
                                          child: UnknownItemDialog(
                                            initialName:
                                                _searchController
                                                    .text
                                                    .isNotEmpty
                                                ? _searchController.text
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.add_box_outlined,
                                      size: 20,
                                    ),
                                    label: Text(
                                      'إضافة صنف يدوي',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Cairo',
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFF59E0B),
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 24.w,
                                        vertical: 12.h,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : AnimationLimiter(
                              child: ListView.separated(
                                controller: scrollController,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 10.h,
                                ),
                                itemCount: state.results.length,
                                separatorBuilder: (c, i) =>
                                    SizedBox(height: 12.h),
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: _BookResultCard(
                                          book: state.results[index],
                                          onAdd: () =>
                                              _addToCart(state.results[index]),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _addToCart(Book book) {
    if (widget.onBookSelected != null) {
      widget.onBookSelected!(book);
      Navigator.pop(context);
    } else {
      final success = context.read<SalesCubit>().addToCart(book);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تمت الإضافة للفاتورة'),
            backgroundColor: Colors.green,
            duration: Duration(milliseconds: 500),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('عفواً، نفذت الكمية المتاحة في المخزن'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        // Drag Handle
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 12.h, bottom: 16.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ),
        // Title Row
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.white),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              Text(
                'بحث وتصفية الكتب',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 48), // Spacer to balance the close button
            ],
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildFilterRow(
    BuildContext context,
    SalesSearchState state,
    SalesSearchCubit cubit,
  ) {
    return SizedBox(
      height: 48.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          // All Chip
          Center(
            child: _buildFilterChip(
              label: 'الكل',
              isSelected:
                  state.selectedPublisher == null &&
                  state.selectedSubject == null &&
                  state.selectedGrade == null &&
                  state.selectedTerm == null,
              onTap: () => cubit.clearFilters(),
            ),
          ),
          SizedBox(width: 8.w),

          // Publisher
          Center(
            child: FilterDropdown(
              label: 'الناشر',
              items: BookConstants.publishers,
              selectedItem: state.selectedPublisher,
              onChanged: cubit.setPublisher,
            ),
          ),
          SizedBox(width: 8.w),

          // Subject
          Center(
            child: FilterDropdown(
              label: 'المادة',
              items: BookConstants.subjects,
              selectedItem: state.selectedSubject,
              onChanged: cubit.setSubject,
            ),
          ),
          SizedBox(width: 8.w),

          // Grade
          Center(
            child: FilterDropdown(
              label: 'الصف',
              items: BookConstants.grades,
              selectedItem: state.selectedGrade,
              onChanged: cubit.setGrade,
            ),
          ),
          SizedBox(width: 8.w),

          // Term (NEW)
          Center(
            child: FilterDropdown(
              label: 'الترم',
              items: BookConstants.terms,
              selectedItem: state.selectedTerm,
              onChanged: cubit.setTerm,
            ),
          ),

          // Add extra padding at end to ensure last dropdown has space to be tapped easily
          SizedBox(width: 40.w),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3B82F6) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: isSelected ? null : Border.all(color: Colors.white24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _BookResultCard extends StatelessWidget {
  final Book book;
  final VoidCallback onAdd;

  const _BookResultCard({required this.book, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final bool isOutOfStock = book.currentStock <= 0;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF111625),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        textDirection: TextDirection.rtl, // Ensure Arabic text direction
        children: [
          // Action Button
          GestureDetector(
            onTap: isOutOfStock ? null : onAdd,
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: isOutOfStock
                    ? Colors.grey.withOpacity(0.2)
                    : const Color(0xFF3B82F6),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add_shopping_cart,
                color: isOutOfStock ? Colors.grey : Colors.white,
                size: 20.sp,
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Info (Center)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stock Badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: isOutOfStock
                        ? Colors.red.withOpacity(0.2)
                        : Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    isOutOfStock
                        ? 'نفذت الكمية'
                        : 'متوفر (${book.currentStock})',
                    style: TextStyle(
                      color: isOutOfStock ? Colors.red : Colors.green,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),

                // Title
                Text(
                  book.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Subtitle
                Text(
                  _buildSubtitle(book),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                ),

                // Price
                Text(
                  '${book.sellPrice.toStringAsFixed(2)} ج.م',
                  style: TextStyle(
                    color: const Color(0xFF3B82F6),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          Container(
            width: 60.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              color: Colors.white24,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  String _buildSubtitle(Book book) {
    if (book.grade != null && book.grade!.isNotEmpty) return book.grade!;
    if (book.subject != null && book.subject!.isNotEmpty) return book.subject!;
    return book.publisher ?? '';
  }
}
