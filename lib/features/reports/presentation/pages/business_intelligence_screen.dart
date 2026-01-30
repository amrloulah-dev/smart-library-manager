import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/reports/presentation/manager/bi_cubit.dart';
import 'package:librarymanager/features/reports/presentation/widgets/bi_section_card.dart';

class BusinessIntelligenceScreen extends StatelessWidget {
  const BusinessIntelligenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<BiCubit>()..loadBiData(),
      child: Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0F172A),
          elevation: 0,
          title: Text(
            'ذكاء الأعمال',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: BlocBuilder<BiCubit, BiState>(
          builder: (context, state) {
            if (state is BiLoading) {
              return const Center(child: CustomLoadingIndicator());
            } else if (state is BiError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (state is BiLoaded) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  children: [
                    _buildSummaryCard(state.dailyInsight),
                    SizedBox(height: 16.h),
                    _buildStockoutSection(state.stockoutPredictions),
                    _buildProfitSection(state.topProfitBooks),
                    _buildSuppliersSection(state.topSuppliers),
                    _buildDeadStockSection(state.deadStock),
                    SizedBox(height: 32.h),
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

  Widget _buildSummaryCard(String insight) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade900.withOpacity(0.8),
            Colors.blue.shade600.withOpacity(0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.auto_awesome,
              color: Colors.blue[200],
              size: 28.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              insight,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockoutSection(List<Book> books) {
    if (books.isEmpty) return const SizedBox.shrink();
    return BiSectionCard(
      title: 'توقعات النفاذ',
      accentColor: const Color(0xFFF97316),
      actionButtonLabel: 'إضافة للنواقص',
      onActionButtonTap: () {
        // Handle Action
      },
      child: SizedBox(
        height: 140.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Column(
                children: [
                  BookCoverWidget(book: book, width: 80.w, height: 100.h),
                  SizedBox(height: 4.h),
                  Text(
                    'باقي: ${book.currentStock}',
                    style: TextStyle(color: Colors.orange, fontSize: 10.sp),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfitSection(List<Book> books) {
    if (books.isEmpty) return const SizedBox.shrink();

    // Sort logic already done in Cubit? Yes.
    // Need top 3 for podium.
    final top3 = books.take(3).toList();
    if (top3.isEmpty) return const SizedBox.shrink();

    return BiSectionCard(
      title: 'الحصان الرابح',
      accentColor: const Color(0xFFFACC15),
      child: Container(
        height: 180.h,
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (top3.length > 1) _buildPodiumItem(top3[1], 2), // 2nd place
            if (top3.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _buildPodiumItem(top3[0], 1, isCenter: true),
              ), // 1st Place
            if (top3.length > 2) _buildPodiumItem(top3[2], 3), // 3rd Place
          ],
        ),
      ),
    );
  }

  Widget _buildPodiumItem(Book book, int rank, {bool isCenter = false}) {
    final height = isCenter ? 140.h : 110.h;
    final color = rank == 1
        ? const Color(0xFFFACC15) // Gold
        : rank == 2
        ? const Color(0xFF94A3B8) // Silver/Grey
        : const Color(0xFFB45309); // Bronze

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Trophy/Badge
        Icon(Icons.emoji_events, color: color, size: isCenter ? 24.sp : 18.sp),
        SizedBox(height: 4.h),
        BookCoverWidget(
          book: book,
          width: isCenter ? 90.w : 70.w,
          height: isCenter ? 110.h : 90.h,
        ),
        SizedBox(height: 4.h),
        SizedBox(
          width: isCenter ? 90.w : 70.w,
          child: Text(
            book.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 10.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildSuppliersSection(List<Supplier> suppliers) {
    if (suppliers.isEmpty) return const SizedBox.shrink();
    final topSupplier = suppliers.first;

    return BiSectionCard(
      title: 'تقييم الموردين',
      accentColor: const Color(0xFF3B82F6),
      child: Column(
        children: [
          // Top Supplier Highlight
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF3B82F6),
                  radius: 24.r,
                  child: Text(
                    topSupplier.name[0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topSupplier.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < (topSupplier.aiScore ?? 0)
                                ? Icons.star
                                : Icons.star_border,
                            color: const Color(0xFFFACC15),
                            size: 16.sp,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Text(
                    'ممتاز',
                    style: TextStyle(color: Colors.green, fontSize: 10.sp),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          // AI Message Bubble
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.blue.withOpacity(0.2)),
                ),
                child: Text(
                  'AI: أداء متميز! معدل المرتجعات لهذا المورد أقل من 2٪ خلال الـ 6 أشهر الماضية.',
                  style: TextStyle(
                    color: Colors.blue[200],
                    fontSize: 11.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Positioned(
                top: -6.h,
                left: 20.w,
                child: Transform.rotate(
                  angle: 0.785, // 45 degrees
                  child: Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      border: Border(
                        top: BorderSide(color: Colors.blue.withOpacity(0.2)),
                        left: BorderSide(color: Colors.blue.withOpacity(0.2)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeadStockSection(List<Book> books) {
    if (books.isEmpty) return const SizedBox.shrink();
    return BiSectionCard(
      title: 'الكتب الراكدة',
      accentColor: const Color(0xFF64748B),
      actionButtonLabel: 'تجهيز المرتجع',
      onActionButtonTap: () {},
      child: SizedBox(
        height: 120.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Opacity(
                opacity: 0.6,
                child: Column(
                  children: [
                    BookCoverWidget(
                      book: book,
                      width: 70.w,
                      height: 90.h,
                      isGrayscale: true,
                    ),
                    SizedBox(height: 4.h),
                    SizedBox(
                      width: 70.w,
                      child: Text(
                        book.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class BookCoverWidget extends StatelessWidget {
  final Book book;
  final double width;
  final double height;
  final bool isGrayscale;

  const BookCoverWidget({
    super.key,
    required this.book,
    required this.width,
    required this.height,
    this.isGrayscale = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          if (!isGrayscale)
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Stack(
        children: [
          // Placeholder for image
          Center(
            child: Icon(
              Icons.book,
              color: isGrayscale ? Colors.white30 : Colors.white54,
              size: width * 0.4,
            ),
          ),
          if (isGrayscale)
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
        ],
      ),
    );
  }
}
