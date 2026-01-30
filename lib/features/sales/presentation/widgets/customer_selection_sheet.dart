import 'package:flutter/material.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:librarymanager/features/sales/presentation/manager/customers_cubit.dart';
import 'package:librarymanager/features/sales/presentation/manager/customers_state.dart';
import 'package:librarymanager/features/sales/presentation/widgets/managers/search_query_cubit.dart';

class CustomerSelectionSheet extends StatefulWidget {
  const CustomerSelectionSheet({super.key});

  @override
  State<CustomerSelectionSheet> createState() => _CustomerSelectionSheetState();
}

class _CustomerSelectionSheetState extends State<CustomerSelectionSheet> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Trigger fetch immediately so data is ready (or loading) when the sheet opens
    context.read<CustomersCubit>().getCustomers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchQueryCubit(),
      child: Builder(
        builder: (context) {
          return Container(
            height: 600.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1E2439),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Column(
              children: [
                // Header / Drag Handle
                SizedBox(height: 12.h),
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 16.h),

                // Search Bar
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF111625),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        context.read<SearchQueryCubit>().updateQuery(value);
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'ابحث باسم العميل أو الرقم...',
                        hintStyle: const TextStyle(color: Colors.white38),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // List Body
                Expanded(
                  child: BlocBuilder<CustomersCubit, CustomersState>(
                    builder: (context, state) {
                      if (state is CustomersLoading) {
                        return const Center(child: CustomLoadingIndicator());
                      } else if (state is CustomersError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      } else if (state is CustomersLoaded) {
                        final allCustomers = state.customers;

                        return BlocBuilder<SearchQueryCubit, String>(
                          builder: (context, searchQuery) {
                            final displayList = allCustomers.where((c) {
                              final query = searchQuery.toLowerCase();
                              final name = c.name.toLowerCase();
                              final phone = c.phone?.toLowerCase() ?? '';
                              return name.contains(query) ||
                                  phone.contains(query);
                            }).toList();

                            // Empty State: If displayList is empty (and query is empty)
                            if (displayList.isEmpty && searchQuery.isEmpty) {
                              return Center(
                                child: Text(
                                  'No customers yet',
                                  style: TextStyle(
                                    color: Colors.white38,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              );
                            }

                            // No search results
                            if (displayList.isEmpty) {
                              return Center(
                                child: Text(
                                  'لا يوجد عملاء',
                                  style: TextStyle(
                                    color: Colors.white38,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              );
                            }

                            return ListView.separated(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              itemCount: displayList.length,
                              separatorBuilder: (_, __) =>
                                  const Divider(color: Colors.white12),
                              itemBuilder: (context, index) {
                                final customer = displayList[index];
                                // Balance Badge (Red if Debt > 0)
                                final isDebt = customer.balance > 0;

                                return InkWell(
                                  onTap: () => Navigator.pop(context, customer),
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12.h,
                                      horizontal: 8.w,
                                    ),
                                    child: Row(
                                      children: [
                                        // Avatar
                                        CircleAvatar(
                                          radius: 20.r,
                                          backgroundColor: const Color(
                                            0xFF3B82F6,
                                          ),
                                          child: Text(
                                            customer.name.isNotEmpty
                                                ? customer.name[0].toUpperCase()
                                                : '?',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 12.w),

                                        // Info
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                customer.name,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 4.h),
                                              Text(
                                                customer.phone ?? 'لا يوجد رقم',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Balance Badge
                                        if (customer.balance != 0)
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.w,
                                              vertical: 4.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isDebt
                                                  ? Colors.red.withOpacity(0.2)
                                                  : Colors.green.withOpacity(
                                                      0.2,
                                                    ),
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              border: Border.all(
                                                color: isDebt
                                                    ? Colors.red
                                                    : Colors.green,
                                                width: 0.5,
                                              ),
                                            ),
                                            child: Text(
                                              customer.balance.toStringAsFixed(
                                                2,
                                              ),
                                              style: TextStyle(
                                                color: isDebt
                                                    ? Colors.red
                                                    : Colors.green,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }

                      // Fallback for initial state or other states
                      return const Center(child: CustomLoadingIndicator());
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
