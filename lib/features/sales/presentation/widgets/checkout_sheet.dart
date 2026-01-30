import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/sales/presentation/manager/sales_cubit.dart';
import 'package:librarymanager/features/sales/presentation/manager/sales_state.dart';
import 'package:librarymanager/features/sales/presentation/widgets/add_customer_dialog.dart';
import 'package:librarymanager/core/utils/ui_utils.dart';
import 'package:get_it/get_it.dart';
import 'package:librarymanager/features/relations/presentation/manager/customers_bloc.dart';
import 'package:librarymanager/features/sales/presentation/manager/customers_cubit.dart';
import 'package:librarymanager/features/sales/presentation/widgets/customer_selection_sheet.dart';

class CheckoutSheet extends StatelessWidget {
  const CheckoutSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesCubit, SalesState>(
      builder: (context, state) {
        // Net Total is already calculated in State
        final netTotal = state.totalAmount;

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Handle
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              // Total Amount
              Text(
                'المجموع الكلي',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16.sp,
                  fontFamily: 'Cairo',
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '${netTotal.toStringAsFixed(2)} ج.م',
                style: TextStyle(
                  color: const Color(0xFFFACC15), // Yellow
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              SizedBox(height: 30.h),

              // Payment Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPaymentButton(
                    context,
                    label: 'كاش',
                    icon: Icons.attach_money,
                    color: const Color(0xFF10B981), // Green
                    onTap: () {
                      context.read<SalesCubit>().checkout(
                        paymentType: 'Cash',
                        // discountOverride: state.discountAmount, // Optional, state is used by default
                      );
                      Navigator.pop(context);
                    },
                  ),
                  _buildPaymentButton(
                    context,
                    label: 'آجل',
                    icon: Icons.account_balance_wallet,
                    color: const Color(0xFFF97316), // Orange
                    onTap: () {
                      if (state.selectedCustomer == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('يرجى اختيار عميل أولاً للبيع الآجل'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        context.read<SalesCubit>().checkout(
                          paymentType: 'Credit',
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),

              SizedBox(height: 30.h),

              const Divider(color: Colors.white12),
              SizedBox(height: 10.h),

              Text(
                'خيارات أخرى',
                style: TextStyle(color: Colors.white54, fontSize: 14.sp),
              ),
              SizedBox(height: 16.h),

              // Customer Section
              Row(
                children: [
                  // Search Bar
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _showCustomerSearch(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF111625),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Colors.grey),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                state.selectedCustomer?.name ??
                                    'بحث عن اسم العميل (للآجل)...',
                                style: TextStyle(
                                  color: state.selectedCustomer != null
                                      ? Colors.white
                                      : Colors.grey,
                                  fontSize: 14.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (state.selectedCustomer != null)
                              GestureDetector(
                                onTap: () => context
                                    .read<SalesCubit>()
                                    .selectCustomer(null),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                  size: 18,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Add Button
                  GestureDetector(
                    onTap: () {
                      final salesCubit = context.read<SalesCubit>();
                      UiUtils.showAnimatedDialog(
                        context,
                        BlocProvider(
                          create: (context) => GetIt.I<CustomersBloc>(),
                          child: AddCustomerDialog(
                            onSuccess: (customer) {
                              salesCubit.selectCustomer(customer);
                            },
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF3B82F6)),
                      ),
                      child: const Icon(
                        Icons.person_add,
                        color: Color(0xFF3B82F6),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h), // Bottom padding
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaymentButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 70.w,
            height: 70.w,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.5)),
            ),
            child: Icon(icon, color: color, size: 30.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }

  void _showCustomerSearch(BuildContext context) async {
    final customer = await showModalBottomSheet<Customer>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider(
        create: (context) => GetIt.I<CustomersCubit>(),
        child: const CustomerSelectionSheet(),
      ),
    );

    if (customer != null && context.mounted) {
      context.read<SalesCubit>().selectCustomer(customer);
    }
  }
}
