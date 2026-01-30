import 'package:flutter/material.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/sales/presentation/manager/relations_cubit.dart';
import 'package:librarymanager/features/sales/presentation/widgets/customer_list_card.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:librarymanager/features/sales/presentation/widgets/customer_payment_dialog.dart';

class CustomersView extends StatelessWidget {
  const CustomersView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Customer>>(
      stream: context.read<RelationsCubit>().customers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CustomLoadingIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        final customers = snapshot.data ?? [];

        if (customers.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.people_outline,
                  size: 64.sp,
                  color: Colors.grey[700],
                ),
                SizedBox(height: 16.h),
                Text(
                  'لا يوجد عملاء حالياً',
                  style: TextStyle(color: Colors.grey[500], fontSize: 16.sp),
                ),
              ],
            ),
          );
        }

        return AnimationLimiter(
          child: ListView.separated(
            padding: EdgeInsets.only(
              left: 16.r,
              right: 16.r,
              top: 16.r,
              bottom: 100.h,
            ),
            itemCount: customers.length,
            separatorBuilder: (context, index) => SizedBox(height: 8.h),
            itemBuilder: (context, index) {
              final customer = customers[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: CustomerListCard(
                      customer: customer,
                      onTap: () => _showPaymentDialog(context, customer),
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

  void _showPaymentDialog(BuildContext context, Customer customer) {
    showDialog(
      context: context,
      builder: (ctx) => BlocProvider.value(
        value: context.read<RelationsCubit>(),
        child: CustomerPaymentDialog(customer: customer),
      ),
    );
  }
}
