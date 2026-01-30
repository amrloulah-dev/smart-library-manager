import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;
import 'package:librarymanager/features/sales/presentation/manager/relations_cubit.dart'
    as librarymanager; // Add prefix to avoid conflict if any

class CustomerListCard extends StatelessWidget {
  final Customer customer;
  final VoidCallback? onTap;

  const CustomerListCard({super.key, required this.customer, this.onTap});

  @override
  Widget build(BuildContext context) {
    // 1) Helper Logic to determine styling
    final debtData = _getDebtStatus(customer.balance);
    final statusColor = debtData.item1;
    final statusText = debtData.item2;

    // Random bg color for Avatar if no image
    final avatarColor = Colors
        .primaries[math.Random(
          customer.name.hashCode,
        ).nextInt(Colors.primaries.length)]
        .shade800;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Row(
              children: [
                // Leading: Avatar
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: avatarColor,
                  child: Text(
                    customer.name.characters.firstOrNull?.toUpperCase() ?? '?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                // Center: Name & Phone
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        customer.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (customer.phone != null) ...[
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(Icons.phone, size: 12.sp, color: Colors.grey),
                            SizedBox(width: 4.w),
                            Text(
                              customer.phone!,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                // Trailing: Balance & Status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${customer.balance.toStringAsFixed(2)} EGP',
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo', // Ensure number font matches
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: statusColor.withOpacity(0.3)),
                      ),
                      child: Text(
                        statusText,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8.w),
                // Delete Icon Button
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Color(0xFFEF4444),
                  ),
                  onPressed: () => _showDeleteConfirmation(context),
                  tooltip: 'حذف العميل',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E2439),
        title: Text(
          'حذف العميل',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
        content: Text(
          'هل أنت متأكد من حذف هذا العميل؟ لا يمكن التراجع عن هذا الإجراء.',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14.sp,
            fontFamily: 'Cairo',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'إلغاء',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14.sp,
                fontFamily: 'Cairo',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<librarymanager.RelationsCubit>().deleteCustomer(
                customer.id,
              );
            },
            child: Text(
              'حذف',
              style: TextStyle(
                color: const Color(0xFFEF4444),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Tuple emulation: item1 = Color, item2 = String
  ({Color item1, String item2}) _getDebtStatus(double balance) {
    if (balance == 0) {
      return (item1: const Color(0xFF10B981), item2: 'خالص'); // Green
    } else if (balance > 1000) {
      return (
        item1: const Color(0xFFEF4444),
        item2: 'حرج',
      ); // Deep Red/Critical (using Red for simplicity or custom purple if defined)
    } else if (balance > 500) {
      return (item1: const Color(0xFFEF4444), item2: 'متأخر'); // Red
    } else {
      return (
        item1: const Color(0xFFF59E0B),
        item2: 'جاري',
      ); // Yellow/Orange/Pending
    }
  }
}
