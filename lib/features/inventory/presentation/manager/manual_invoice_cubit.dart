import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:librarymanager/features/inventory/presentation/manager/manual_invoice_state.dart';
import 'package:librarymanager/features/invoices/domain/models/scanned_item_model.dart';
import 'package:librarymanager/app/injection.dart';
import 'package:librarymanager/core/services/supabase_sync_service.dart';

import 'package:get_it/get_it.dart';
import 'package:librarymanager/features/inventory/presentation/manager/inventory_cubit.dart';

@injectable
class ManualInvoiceCubit extends Cubit<ManualInvoiceState> {
  final InventoryRepository _inventoryRepository;

  ManualInvoiceCubit(this._inventoryRepository)
    : super(ManualInvoiceState(invoiceDate: DateTime.now()));

  void selectSupplier(Supplier supplier) {
    emit(state.copyWith(selectedSupplier: supplier));
  }

  void updateDate(DateTime date) {
    emit(state.copyWith(invoiceDate: date));
  }

  void addItem(ManualInvoiceItem item) {
    final updatedItems = List<ManualInvoiceItem>.from(state.items)..add(item);
    emit(state.copyWith(items: updatedItems));
  }

  void removeItem(int index) {
    if (index >= 0 && index < state.items.length) {
      final updatedItems = List<ManualInvoiceItem>.from(state.items)
        ..removeAt(index);
      emit(state.copyWith(items: updatedItems));
    }
  }

  void updateDiscount(double percent) {
    emit(state.copyWith(discountPercent: percent));
  }

  void updatePaidAmount(double amount) {
    emit(state.copyWith(paidAmount: amount));
  }

  Future<void> saveInvoice() async {
    if (state.selectedSupplier == null) {
      emit(state.copyWith(error: 'الرجاء اختيار المورد'));
      return;
    }

    if (state.items.isEmpty) {
      emit(state.copyWith(error: 'الفاتورة فارغة'));
      return;
    }

    emit(state.copyWith(isSubmitting: true));

    try {
      // 1. Calculate Subtotal (Sum of all items total cost)
      final subtotal = state.items.fold(
        0.0,
        (sum, item) => sum + item.totalCost,
      );

      // 2. Calculate Discount Value (Money) from percentage
      final discountValue = subtotal * (state.discountPercent / 100);

      // Map ManualInvoiceItem to ScannedItemModel
      final scannableItems = state.items.map((item) {
        return ScannedItemModel(
          name: item.bookName,
          quantity: item.quantity,
          price: item.costPrice,
          sellPrice: item.sellPrice,
        );
      }).toList();

      await _inventoryRepository.createPurchaseInvoice(
        state.selectedSupplier!.id,
        scannableItems,
        discountValue,
        state.invoiceDate!,
        paidAmount: state.paidAmount,
      );

      emit(
        state.copyWith(
          isSubmitting: false,
          successMessage: 'تم حفظ الفاتورة بنجاح',
          items: [], // Clear items after save
          discountPercent: 0.0,
          paidAmount: 0.0,
        ),
      );

      // Trigger Inventory Refresh
      if (GetIt.I.isRegistered<InventoryCubit>()) {
        GetIt.I<InventoryCubit>().loadBooks(isRefresh: true);
      }

      // Trigger Sync
      Future.delayed(const Duration(seconds: 1), () {
        getIt<SupabaseSyncService>().syncPendingData();
      });
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, error: 'حدث خطأ: $e'));
    }
  }
}
