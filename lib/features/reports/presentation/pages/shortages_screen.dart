import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:librarymanager/features/reports/presentation/manager/shortages_cubit.dart';
import 'package:librarymanager/features/reports/presentation/widgets/shortage_cards.dart';
import 'package:librarymanager/features/reports/presentation/widgets/smart_shortage_card.dart';

class ShortagesScreen extends StatelessWidget {
  const ShortagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensuring the cubit is provided if not already by the router.
    // Assuming AppRouter provides it. If not, this widget just consumes it.
    // Trigger fetch on load if needed, but Cubit usually does it in constructor.
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'الذكاء الاصطناعي للنواقص',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
            fontSize: 18.sp,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<ShortagesCubit, ShortagesState>(
        builder: (context, state) {
          if (state is ShortagesLoading) {
            return const Center(child: CustomLoadingIndicator());
          } else if (state is ShortagesError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else if (state is ShortagesLoaded) {
            if (state.items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 64.sp,
                      color: Colors.greenAccent,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'المخزون مثالي!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    Text(
                      'لا توجد نواقص أو حجوزات حالياً',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              );
            }

            // Split items for sections
            final reservations = state.items
                .where((i) => i.type == ShortageType.reservation)
                .toList();
            final outOfStock = state.items
                .where((i) => i.type == ShortageType.outOfStock)
                .toList();
            final suggestions = state.items
                .where((i) => i.type == ShortageType.smartRestock)
                .toList();

            return CustomScrollView(
              slivers: [
                // SECTION 1: CUSTOMER ORDERS
                if (reservations.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: _buildSectionHeader(
                      'طلبات العملاء (حجوزات)',
                      reservations.length,
                      Icons.people_alt_rounded,
                      Colors.blueAccent,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = reservations[index];
                      if (item.reservation != null) {
                        return ReservedItemCard(reservation: item.reservation!);
                      }
                      return const SizedBox.shrink();
                    }, childCount: reservations.length),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                ],

                // SECTION 2: OUT OF STOCK ITEMS
                if (outOfStock.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: _buildSectionHeader(
                      'أصناف نفذت (Shortages)',
                      outOfStock.length,
                      Icons.inventory_2_outlined,
                      Colors.orangeAccent,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return SmartShortageCard(item: outOfStock[index]);
                    }, childCount: outOfStock.length),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                ],

                // SECTION 3: AI RESTOCK SUGGESTIONS
                if (suggestions.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: _buildSectionHeader(
                      'مقترحات التوريد (AI)',
                      suggestions.length,
                      Icons.auto_awesome,
                      Colors.purpleAccent,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return SmartShortageCard(item: suggestions[index]);
                    }, childCount: suggestions.length),
                  ),
                ],

                // Bottom Padding
                SliverToBoxAdapter(child: SizedBox(height: 100.h)),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BlocBuilder<ShortagesCubit, ShortagesState>(
        builder: (context, state) {
          if (state is! ShortagesLoaded || state.items.isEmpty) {
            return const SizedBox.shrink();
          }

          return Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2439),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<ShortagesCubit>().sendToWhatsApp();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم تحويل القائمة للواتساب')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                icon: const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.white,
                ),
                label: Text(
                  'إرسال للمورد',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    int count,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: color, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white10),
            ),
            child: Text(
              '$count items',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.sp,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
