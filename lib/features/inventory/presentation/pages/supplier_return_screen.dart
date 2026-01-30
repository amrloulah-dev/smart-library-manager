import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:librarymanager/app/injection.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/inventory/presentation/manager/inventory_cubit.dart';
import 'package:librarymanager/features/inventory/presentation/manager/manual_invoice_state.dart';
import 'package:librarymanager/features/inventory/presentation/manager/supplier_return_cubit.dart';
import 'package:librarymanager/features/inventory/presentation/widgets/manual_entry_sheet.dart';
import 'package:librarymanager/features/reports/presentation/widgets/return_confirmation_dialog.dart';

class SupplierReturnScreen extends StatefulWidget {
  const SupplierReturnScreen({super.key});

  @override
  State<SupplierReturnScreen> createState() => _SupplierReturnScreenState();
}

class _SupplierReturnScreenState extends State<SupplierReturnScreen> {
  Supplier? _selectedSupplier;
  final List<ManualInvoiceItem> _items = [];
  double _discountPercentage = 0.0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<SupplierReturnCubit>()),
        BlocProvider.value(value: getIt<InventoryCubit>()),
      ],
      child: BlocConsumer<SupplierReturnCubit, SupplierReturnState>(
        listener: (context, state) {
          if (state is SupplierReturnSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            context.pop();
          } else if (state is SupplierReturnError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFF0F172A),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'مرتجع الموردين',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => context.pop(),
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  _buildHeader(context),
                  _buildItemsList(),
                  if (_items.isNotEmpty) _buildBottomAction(context),
                ],
              ),
            ),
            floatingActionButton: _selectedSupplier != null
                ? FloatingActionButton(
                    backgroundColor: const Color(0xFF3B82F6),
                    onPressed: () => _showAddEntrySheet(context),
                    child: const Icon(Icons.add, color: Colors.white),
                  )
                : null,
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'اختر المورد',
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
          SizedBox(height: 8.h),
          BlocBuilder<InventoryCubit, InventoryState>(
            builder: (context, invState) {
              return StreamBuilder<List<Supplier>>(
                stream: context.read<InventoryCubit>().suppliersStream,
                builder: (context, snapshot) {
                  final suppliers = snapshot.data ?? [];
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Supplier>(
                        value: _selectedSupplier,
                        hint: const Text(
                          'المورد',
                          style: TextStyle(color: Colors.white54),
                        ),
                        dropdownColor: const Color(0xFF1E293B),
                        isExpanded: true,
                        items: suppliers.map((s) {
                          return DropdownMenuItem(
                            value: s,
                            child: Text(
                              s.name,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            _selectedSupplier = val;
                          });
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
          if (_selectedSupplier != null) ...[
            SizedBox(height: 16.h),
            _buildDiscountField(),
          ],
        ],
      ),
    );
  }

  Widget _buildDiscountField() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'نسبة الخصم %',
                hintStyle: TextStyle(color: Colors.white54),
              ),
              onChanged: (val) {
                _discountPercentage = double.tryParse(val) ?? 0.0;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItemsList() {
    if (_items.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.inventory_2_outlined,
                size: 64.sp,
                color: Colors.white24,
              ),
              SizedBox(height: 16.h),
              Text(
                'قائمة المرتجع فارغة',
                style: TextStyle(color: Colors.white24, fontSize: 16.sp),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: _items.length,
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final item = _items[index];
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.bookName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${item.quantity} نسخه × ${item.costPrice} ج.م',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${(item.quantity * item.costPrice).toStringAsFixed(0)} ج.م',
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    setState(() {
                      _items.removeAt(index);
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    final double totalValue = _items.fold(
      0,
      (sum, item) => sum + (item.quantity * item.costPrice),
    );
    final double finalValue = totalValue * (1 - (_discountPercentage / 100));

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'إجمالي القيمة:',
                style: TextStyle(color: Colors.white70),
              ),
              Text(
                '${totalValue.toStringAsFixed(1)} ج.م',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'الصافي بعد الخصم:',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${finalValue.toStringAsFixed(1)} ج.م',
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: () => _confirmReturn(context, finalValue),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: const Text(
                'تأكيد المرتجع',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEntrySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<InventoryCubit>(),
        child: ManualEntrySheet(
          isReturnMode: true,
          onAdd: (item) {
            setState(() {
              _items.add(item);
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _confirmReturn(BuildContext context, double finalValue) {
    showDialog(
      context: context,
      builder: (diagContext) => ReturnConfirmationDialog(
        totalValue: finalValue,
        onConfirm: () {
          Navigator.pop(diagContext);

          final Map<String, int> itemMap = {
            for (var item in _items) item.bookId!: item.quantity,
          };

          context.read<SupplierReturnCubit>().executeReturnWithIds(
            _selectedSupplier!.id,
            itemMap,
            _discountPercentage,
          );
        },
        onCancel: () => Navigator.pop(diagContext),
      ),
    );
  }
}
