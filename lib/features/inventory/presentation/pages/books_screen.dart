import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:librarymanager/features/inventory/presentation/manager/inventory_cubit.dart';
import 'package:librarymanager/features/inventory/presentation/widgets/inventory_book_card.dart';
import 'package:librarymanager/features/inventory/presentation/widgets/inventory_filter_list.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BooksView();
  }
}

class BooksView extends StatefulWidget {
  const BooksView({super.key});

  @override
  State<BooksView> createState() => _BooksViewState();
}

class _BooksViewState extends State<BooksView> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InventoryCubit>().loadInventoryItems();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<InventoryCubit>().loadMoreBooks();
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
    // Ensure we are listening to or accessing Cubit
    final cubit = context.read<InventoryCubit>();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Dark Navy
      appBar: AppBar(
        title: Text(
          'المخزن',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header: Search & Filter Icon
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                  hintText: 'بحث باسم الكتاب أو المؤلف...',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14.sp,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Filter Chips List
          BlocBuilder<InventoryCubit, InventoryState>(
            builder: (context, state) {
              return InventoryFilterList(
                activeFilter: cubit.selectedFilter,
                onSelected: (filter) {
                  cubit.updateFilter(filter);
                },
              );
            },
          ),

          SizedBox(height: 12.h),

          // Books List
          Expanded(
            child: BlocBuilder<InventoryCubit, InventoryState>(
              builder: (context, state) {
                if (state is InventoryLoading) {
                  return const Center(child: CustomLoadingIndicator());
                }
                if (state is InventoryError) {
                  return const Center(
                    child: Text(
                      'حدث خطأ', // Simplified as requested
                      style: TextStyle(color: Colors.white),
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
                            Icons.library_books_outlined,
                            size: 64.sp,
                            color: Colors.grey[700],
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            "المخزن فارغ! استخدم زر '+' للإضافة",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final width = MediaQuery.sizeOf(context).width;
                  int crossAxisCount = width < 600 ? 1 : (width < 900 ? 2 : 4);
                  double aspectRatio = width < 600 ? 2.8 : 0.85;

                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: AnimationLimiter(
                        child: GridView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.all(16.r),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 12.w,
                                mainAxisSpacing: 12.h,
                                childAspectRatio: aspectRatio,
                              ),
                          itemCount: state.hasReachedMax
                              ? state.items.length
                              : state.items.length + 1,
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
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              columnCount: crossAxisCount,
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: InventoryBookCard(book: book),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 64.w,
        height: 64.w,
        child: FloatingActionButton(
          heroTag: 'inventory_fab_new',
          backgroundColor: const Color(0xFF3B82F6), // Electric Blue
          elevation: 8,
          shape: const CircleBorder(),
          child: Icon(Icons.add, color: Colors.white, size: 32.sp),
          onPressed: () => _showInventoryActions(context),
        ),
      ),
    );
  }

  void _showInventoryActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E2439),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildActionTile(
                context,
                icon: Icons.edit_note_rounded,
                title: 'فاتورة يدوية ✍️',
                onTap: () {
                  Navigator.pop(context); // Close sheet
                  context.push('/inventory/manual_entry').then((_) {
                    if (context.mounted) {
                      context.read<InventoryCubit>().loadBooks(isRefresh: true);
                    }
                  });
                },
              ),
              Divider(color: Colors.white.withOpacity(0.1), height: 32.h),
              _buildActionTile(
                context,
                icon: Icons.camera_alt_outlined,
                title: 'امسح الفاتورة ضوئيًا 📸',
                onTap: () {
                  Navigator.pop(context); // Close sheet
                  context.push('/inventory/invoice_scanner').then((_) {
                    if (context.mounted) {
                      context.read<InventoryCubit>().loadBooks(isRefresh: true);
                    }
                  });
                },
              ),
              Divider(color: Colors.white.withOpacity(0.1), height: 32.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF3B82F6), size: 24.sp),
            ),
            SizedBox(width: 16.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[600], size: 16.sp),
          ],
        ),
      ),
    );
  }
}
