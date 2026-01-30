import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:librarymanager/features/inventory/presentation/manager/inventory_cubit.dart';
import '../../../../core/theme/app_theme.dart';
import 'package:get_it/get_it.dart';

class SuppliersScreen extends StatelessWidget {
  const SuppliersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GetIt.I<InventoryCubit>(),
      child: const SuppliersView(),
    );
  }
}

class SuppliersView extends StatelessWidget {
  const SuppliersView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<InventoryCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('الموردين')),

      body: BlocListener<InventoryCubit, InventoryState>(
        listener: (context, state) {
          if (state is InventorySuccess && state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
                backgroundColor: AppTheme.emeraldGreen,
              ),
            );
          } else if (state is InventoryError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.roseRed,
              ),
            );
          }
        },
        child: StreamBuilder<List<Supplier>>(
          stream: cubit.suppliersStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CustomLoadingIndicator());
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'خطأ في تحميل البيانات',
                  style: TextStyle(color: AppTheme.roseRed),
                ),
              );
            }

            final suppliers = snapshot.data ?? [];

            if (suppliers.isEmpty) {
              return const Center(child: Text('لا يوجد موردين حالياً'));
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: suppliers.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final supplier = suppliers[index];
                return _buildSupplierCard(supplier);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildSupplierCard(Supplier supplier) {
    final balance = supplier.balance;
    final isNegative =
        balance <
        0; // The library owes the supplier (Usually positive means supplier owes library, negative means library owes supplier? Requirement says: >0 We owe them. Wait. Let's re-read.)
    // Re-reading requirements:
    // "If balance > 0 (We owe them): Red Background."
    // "If balance == 0: Green Background."
    // "If balance < 0 (They owe us): Green Background."

    // NOTE: Usually in accounting:
    // Supplier Account (Liability): Credit is positive.
    // But implementation depends on business logic.
    // I will strictly follow Requirement text: "> 0 We owe them -> Red".

    Color badgeColor;
    if (balance > 0) {
      badgeColor = AppTheme.roseRed;
    } else {
      badgeColor = AppTheme.emeraldGreen;
    }

    return Card(
      color: AppTheme.glassyDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Balance Badge (Left Side per requirement? Or Left side relative to text direction? Arabic is RTL. So "Left Side" visually means Left.)
            // In RTL, Leading is Right.
            // "Balance Badge (Left Side)" likely means visual Left. In LTR that's Trailing. In RTL that's Leading (end of row visually).
            // Let's assume standard intuitive UI: Name on Right (Start), Badge on Left (End).
            // In Row with RTL context: Children start from Right.
            // So: [Name/Phone (Expanded), Badge]
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    supplier.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    supplier.phone ?? 'لا يوجد رقم هاتف',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${balance.abs()} EGP',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
