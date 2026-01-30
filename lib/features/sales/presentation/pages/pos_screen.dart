import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:librarymanager/core/constants/book_constants.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/theme/app_theme.dart';
import 'package:librarymanager/features/sales/presentation/manager/sales_cubit.dart';
import 'package:librarymanager/features/sales/presentation/manager/sales_state.dart';
import 'package:librarymanager/features/sales/presentation/widgets/checkout_sheet.dart';
import 'package:librarymanager/features/sales/presentation/widgets/filter_dropdown.dart';
import 'package:librarymanager/features/sales/presentation/widgets/pos_cart_item.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:librarymanager/features/sales/presentation/widgets/customer_return_sheet.dart';
import 'package:librarymanager/features/sales/presentation/widgets/book_exchange_dialog.dart';

class PosScreen extends StatefulWidget {
  final String? bookId;
  const PosScreen({super.key, this.bookId});

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final cubit = context.read<SalesCubit>();

    // Initialize Catalog
    cubit.loadAllBooks();

    // Check for passed bookId or reservation data
    if (widget.bookId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        cubit.fetchAndAddBook(widget.bookId!);
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final extra = GoRouterState.of(context).extra;
      if (extra is Map<String, dynamic>) {
        if (extra.containsKey('reservationId')) {
          cubit.setLinkedReservationId(extra['reservationId']);
        }
        if (extra.containsKey('bookId') && widget.bookId == null) {
          cubit.fetchAndAddBook(extra['bookId']);
        }
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      resizeToAvoidBottomInset: false,

      body: SafeArea(
        child: Column(
          children: [
            // Top Section: Search & Filters
            _buildTopSection(),

            // Middle Section: Book List
            Expanded(child: _buildBookList()),

            // Bottom Section: Cart Summary
            _buildCartSummary(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
      ),
      child: Column(
        children: [
          // Header Row with Back Button & Title
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () => context.pop(),
              ),
              Text(
                'نقطة البيع (POS)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              // Options Button (Return/Exchange)
              IconButton(
                onPressed: () => _showOptionsSheet(context),
                icon: const Icon(Icons.more_vert, color: Colors.white),
                tooltip: 'خيارات إضافية',
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Search Bar
          TextField(
            controller: _searchController,
            onChanged: (val) {
              context.read<SalesCubit>().updateCatalogFilters(searchQuery: val);
            },
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
            decoration: InputDecoration(
              hintText: 'ابحث عن كتاب...',
              hintStyle: TextStyle(color: Colors.white30, fontSize: 14.sp),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: const Color(0xFF111625),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Filters Row
          _buildFilters(),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return BlocBuilder<SalesCubit, SalesState>(
      buildWhen: (previous, current) =>
          previous.filterPublisher != current.filterPublisher ||
          previous.filterSubject != current.filterSubject ||
          previous.filterGrade != current.filterGrade,
      builder: (context, state) {
        return SizedBox(
          height: 40.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              // All Filter
              _buildFilterChip(
                label: 'الكل',
                isActive:
                    state.filterPublisher == null &&
                    state.filterSubject == null &&
                    state.filterGrade == null,
                onTap: () {
                  context.read<SalesCubit>().updateCatalogFilters(
                    clearPublisher: true,
                    clearSubject: true,
                    clearGrade: true,
                  );
                },
              ),
              SizedBox(width: 8.w),

              // Publisher Filter
              // Using Dropdown logic but triggered from chip or just standard chips?
              // Request said "Filter Chips/Buttons".
              // Dropdowns are better for long lists.
              // I will use FilterDropdown widget I have access to.
              FilterDropdown(
                label: 'الناشر',
                items: BookConstants.publishers,
                selectedItem: state.filterPublisher,
                onChanged: (val) =>
                    context.read<SalesCubit>().updateCatalogFilters(
                      publisher: val,
                      clearPublisher: val == null,
                    ),
              ),
              SizedBox(width: 8.w),

              FilterDropdown(
                label: 'المادة',
                items: BookConstants.subjects,
                selectedItem: state.filterSubject,
                onChanged: (val) =>
                    context.read<SalesCubit>().updateCatalogFilters(
                      subject: val,
                      clearSubject: val == null,
                    ),
              ),
              SizedBox(width: 8.w),

              FilterDropdown(
                label: 'الصف',
                items: BookConstants.grades,
                selectedItem: state.filterGrade,
                onChanged: (val) => context
                    .read<SalesCubit>()
                    .updateCatalogFilters(grade: val, clearGrade: val == null),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: isActive ? null : Border.all(color: Colors.white24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildBookList() {
    return BlocBuilder<SalesCubit, SalesState>(
      // Rebuild when book lists change
      buildWhen: (pv, cv) => pv.filteredBooks != cv.filteredBooks,
      builder: (context, state) {
        if (state.filteredBooks.isEmpty) {
          // Empty State
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.menu_book, size: 60.sp, color: Colors.white10),
                SizedBox(height: 16.h),
                Text(
                  'لم يتم العثور على نتائج',
                  style: TextStyle(color: Colors.white30, fontSize: 16.sp),
                ),
              ],
            ),
          );
        }

        // Grid View
        final width = MediaQuery.sizeOf(context).width;
        int crossAxisCount = width < 600 ? 2 : (width < 900 ? 3 : 4);
        double aspectRatio = 0.75;

        return AnimationLimiter(
          child: GridView.builder(
            padding: EdgeInsets.all(16.r),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: aspectRatio,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
            ),
            itemCount: state.filteredBooks.length,
            itemBuilder: (context, index) {
              final book = state.filteredBooks[index];
              return AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: crossAxisCount,
                duration: const Duration(milliseconds: 375),
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: _BookCatalogueItem(
                      book: book,
                      onTap: () {
                        final success = context.read<SalesCubit>().addToCart(
                          book,
                        );
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('تمت إضافة: ${book.name}'),
                              duration: const Duration(milliseconds: 500),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('نفذت الكمية!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCartSummary() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: BlocConsumer<SalesCubit, SalesState>(
              listener: (context, state) {
                if (state.status == SalesStatus.success) {
                  _discountController.clear();
                }
              },
              builder: (context, state) {
                final itemCount = state.cartItems.fold<int>(
                  0,
                  (sum, item) => sum + item.quantity,
                );

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 1. Discount Controls
                    Row(
                      children: [
                        // Presets
                        _buildDiscountPreset(
                          context,
                          13,
                          state.discountPercentage,
                        ),
                        SizedBox(width: 8.w),
                        _buildDiscountPreset(
                          context,
                          15,
                          state.discountPercentage,
                        ),
                        SizedBox(width: 8.w),
                        _buildDiscountPreset(
                          context,
                          18,
                          state.discountPercentage,
                        ),
                        SizedBox(width: 12.w),

                        // Custom Field
                        Expanded(
                          child: SizedBox(
                            height: 40.h,
                            child: TextField(
                              controller: _discountController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'مخصص %',
                                hintStyle: TextStyle(
                                  color: Colors.white30,
                                  fontSize: 12.sp,
                                ),
                                filled: true,
                                fillColor: const Color(0xFF111625),
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: const BorderSide(
                                    color: AppTheme.primaryBlue,
                                  ),
                                ),
                              ),
                              onChanged: (val) {
                                final p = double.tryParse(val);
                                if (p != null) {
                                  context
                                      .read<SalesCubit>()
                                      .applyGlobalDiscount(p);
                                } else if (val.isEmpty) {
                                  context
                                      .read<SalesCubit>()
                                      .applyGlobalDiscount(0);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // 2. Existing Summary Row
                    Row(
                      children: [
                        // Checkout Button (Left)
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: 54.h,
                            child: ElevatedButton(
                              onPressed: state.cartItems.isEmpty
                                  ? null
                                  : () {
                                      _showCheckout(context);
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryBlue,
                                disabledBackgroundColor: Colors.grey
                                    .withOpacity(0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                elevation: 4,
                                shadowColor: AppTheme.primaryBlue.withOpacity(
                                  0.4,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.white,
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'دفع',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),

                        // Total Amount (Middle)
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () => _showCartDetails(context),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${state.totalAmount.toStringAsFixed(2)} ج.م',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (state.discountAmount > 0)
                                  Text(
                                    'خصم: ${state.discountAmount.toStringAsFixed(1)}',
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 10.sp,
                                    ),
                                  )
                                else
                                  Text(
                                    '$itemCount عناصر',
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),

                        // Cart Badge (Right)
                        GestureDetector(
                          onTap: () => _showCartDetails(context),
                          child: Stack(
                            alignment: Alignment.topRight,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                padding: EdgeInsets.all(12.r),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.05),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.white,
                                  size: 24.sp,
                                ),
                              ),
                              if (state.cartItems.isNotEmpty)
                                Positioned(
                                  top: -4,
                                  right: -4,
                                  child: Container(
                                    padding: EdgeInsets.all(6.r),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 20.w,
                                      minHeight: 20.w,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${state.cartItems.length}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                        height: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDiscountPreset(
    BuildContext context,
    double value,
    double currentDiscount,
  ) {
    final isSelected = (currentDiscount == value);
    return GestureDetector(
      onTap: () {
        if (isSelected) {
          // Toggle off
          context.read<SalesCubit>().applyGlobalDiscount(0);
          _discountController.clear();
        } else {
          context.read<SalesCubit>().applyGlobalDiscount(value);
          _discountController.text = value.toStringAsFixed(0);
        }
      },
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryBlue : const Color(0xFF111625),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryBlue
                : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Text(
          '${value.toInt()}%',
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showCartDetails(BuildContext context) {
    final cubit = context.read<SalesCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          BlocProvider.value(value: cubit, child: _CartDetailsSheet()),
    );
  }

  void _showOptionsSheet(BuildContext context) {
    final cubit = context.read<SalesCubit>();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1E2439),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOptionTile(
              icon: Icons.keyboard_return,
              title: 'مرتجع',
              subtitle: 'إرجاع كتاب واسترداد المبلغ',
              color: const Color(0xFFF43F5E),
              onTap: () {
                Navigator.pop(ctx);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => BlocProvider.value(
                    value: cubit,
                    child: const CustomerReturnSheet(),
                  ),
                );
              },
            ),
            SizedBox(height: 16.h),
            _buildOptionTile(
              icon: Icons.swap_horiz,
              title: 'استبدال',
              subtitle: 'استبدال كتاب بآخر مع حساب الفرق',
              color: const Color(0xFF3B82F6),
              onTap: () {
                Navigator.pop(ctx);
                showDialog(
                  context: context,
                  builder: (_) => BlocProvider.value(
                    value: cubit,
                    child: const BookExchangeDialog(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.white54, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16.sp),
          ],
        ),
      ),
    );
  }

  void _showCheckout(BuildContext context) {
    final cubit = context.read<SalesCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          BlocProvider.value(value: cubit, child: const CheckoutSheet()),
    );
  }
}

// Inner Widget for Book Tile
class _BookCatalogueItem extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const _BookCatalogueItem({required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isOutOfStock = book.currentStock <= 0;

    return GestureDetector(
      onTap: isOutOfStock ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF111625),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top: Placeholder Image / Icon
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.book_rounded,
                    size: 40.sp,
                    color: Colors.white24,
                  ),
                ),
              ),
            ),

            // Info
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          book.publisher ?? book.subject ?? 'غير محدد',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${book.sellPrice.toInt()} ر.س',
                          style: TextStyle(
                            color: AppTheme.primaryBlue,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Stock Indicator
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: isOutOfStock
                                ? Colors.red.withOpacity(0.2)
                                : Colors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            isOutOfStock ? '0' : '${book.currentStock}',
                            style: TextStyle(
                              color: isOutOfStock ? Colors.red : Colors.green,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Inner Widget to show Cart Details (since we removed the half-screen list)
class _CartDetailsSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.7.sh,
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'سلة المشتريات',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white10),
          Expanded(
            child: BlocBuilder<SalesCubit, SalesState>(
              builder: (context, state) {
                if (state.cartItems.isEmpty) {
                  return const Center(
                    child: Text(
                      'السلة فارغة',
                      style: TextStyle(color: Colors.white54),
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.all(16.r),
                  itemCount: state.cartItems.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    // Reuse PosCartItemWidget but I don't have reference to it directly here unless I import it.
                    // I will duplicate a simple tile or try to import `pos_cart_item.dart` which IS imported at top.
                    // But I need to verify `PosCartItem` class vs `PosCartItemWidget`.
                    // Import at top: `import 'package:librarymanager/features/sales/presentation/widgets/pos_cart_item.dart';`
                    // It usually exports `PosCartItemWidget`.
                    return PosCartItemWidget(
                      item: state.cartItems[index],
                      index: index,
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<SalesCubit>().clearCart();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                label: const Text(
                  'إفراغ السلة',
                  style: TextStyle(color: Colors.red),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.withOpacity(0.1),
                  elevation: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
