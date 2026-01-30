import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/theme/app_theme.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:librarymanager/features/inventory/presentation/widgets/add_supplier_sheet.dart';
import 'package:librarymanager/features/operations/presentation/widgets/add_reservation_sheet.dart';
import 'package:librarymanager/features/sales/presentation/manager/relations_cubit.dart';
import 'package:librarymanager/features/sales/presentation/pages/views/customers_view.dart';
import 'package:librarymanager/features/sales/presentation/pages/views/reservations_view.dart';
import 'package:librarymanager/features/sales/presentation/widgets/add_customer_dialog.dart';
import 'package:librarymanager/features/sales/presentation/widgets/relations_widgets.dart';
import 'package:librarymanager/core/utils/ui_utils.dart';
import 'package:librarymanager/features/relations/presentation/manager/customers_bloc.dart';

class RelationsScreen extends StatelessWidget {
  const RelationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<RelationsCubit>(),
      child: const _RelationsView(),
    );
  }
}

class _RelationsView extends StatefulWidget {
  const _RelationsView();

  @override
  State<_RelationsView> createState() => _RelationsViewState();
}

class _RelationsViewState extends State<_RelationsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging ||
          _tabController.animation!.value == _tabController.index) {
        context.read<RelationsCubit>().changeTab(_tabController.index);
        setState(() {}); // Rebuild to update FAB
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        title: Text(
          'العلاقات',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            height: 50.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1E2439),
              borderRadius: BorderRadius.circular(25.r),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              splashFactory: NoSplash.splashFactory,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                color: const Color(0xFF3B82F6),
                borderRadius: BorderRadius.circular(25.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
              tabs: const [
                Tab(text: 'الموردين'),
                Tab(text: 'العملاء'),
                Tab(text: 'الحجوزات'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSuppliersTab(context),
          const CustomersView(),
          const ReservationsView(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    IconData icon;
    VoidCallback onPressed;
    String tooltip;

    switch (_tabController.index) {
      case 0: // Suppliers
        icon = Icons.add;
        onPressed = () => _showAddSupplierDialog(context);
        tooltip = 'Add Supplier';
        break;
      case 1: // Customers
        icon = Icons.person_add;
        onPressed = () => _showAddCustomerDialog(context);
        tooltip = 'Add Customer';
        break;
      case 2: // Reservations
        icon = Icons.bookmark_add;
        onPressed = () => _showAddReservationDialog(context);
        tooltip = 'Add Reservation';
        break;
      default:
        return const SizedBox.shrink();
    }

    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: const Color(0xFF3B82F6),
      tooltip: tooltip,
      child: Icon(icon, size: 28.sp),
    );
  }

  void _showAddSupplierDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => BlocProvider.value(
        value: context.read<RelationsCubit>(),
        child: const AddSupplierSheet(),
      ),
    );
  }

  void _showAddCustomerDialog(BuildContext context) {
    UiUtils.showAnimatedDialog(
      context,
      BlocProvider(
        create: (context) => GetIt.I<CustomersBloc>(),
        child: const AddCustomerDialog(),
      ),
    );
  }

  void _showAddReservationDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => BlocProvider.value(
        value: context.read<RelationsCubit>(),
        child: const AddReservationSheet(),
      ),
    );
  }

  Widget _buildSuppliersTab(BuildContext context) {
    return StreamBuilder<List<Supplier>>(
      stream: context.read<RelationsCubit>().suppliers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CustomLoadingIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'لا يوجد موردين',
              style: TextStyle(color: Colors.grey[400], fontSize: 16.sp),
            ),
          );
        }

        final suppliers = snapshot.data!;
        final stats = context.read<RelationsCubit>().calculateSupplierStats(
          suppliers,
        );

        return AnimationLimiter(
          child: ListView(
            padding: EdgeInsets.all(16.r),
            children: [
              // Stats Row
              Row(
                children: [
                  Expanded(
                    child: RelationsStatsCard(
                      title: 'إجمالي الديون',
                      value: "${stats['totalDebt']?.toStringAsFixed(1)}",
                      icon: Icons.arrow_downward,
                      color: AppTheme.roseRed,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: RelationsStatsCard(
                      title: 'مستحقات لنا',
                      value: "${stats['totalCredit']?.toStringAsFixed(1)}",
                      icon: Icons.arrow_upward,
                      color: AppTheme.emeraldGreen,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: FutureBuilder<double>(
                      future: context
                          .read<RelationsCubit>()
                          .getGlobalTotalPaidToSuppliers(),
                      builder: (context, snapshot) {
                        final val = snapshot.data ?? 0.0;
                        return RelationsStatsCard(
                          title: 'المدفوع',
                          value: val.toStringAsFixed(1),
                          icon: Icons.check_circle_outline,
                          color: const Color(0xFF3B82F6),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // Section Title
              Row(
                children: [
                  Text(
                    'قائمة الموردين',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      '${suppliers.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Suppliers List
              ...suppliers.asMap().entries.map((entry) {
                return AnimationConfiguration.staggeredList(
                  position: entry.key,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: SupplierCard(supplier: entry.value),
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
