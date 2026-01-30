import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/reports/domain/models/invoice_with_status.dart';
import 'package:librarymanager/features/inventory/domain/repositories/inventory_repository.dart';

part 'invoices_history_state.dart';

@injectable
class InvoicesHistoryCubit extends Cubit<InvoicesHistoryState> {
  final AppDatabase _db;
  final InventoryRepository _inventoryRepository;

  InvoicesHistoryCubit(this._db, this._inventoryRepository)
    : super(InvoicesHistoryInitial());

  String _currentFilter = 'all';

  Future<void> loadInvoices(String supplierId, {String filter = 'all'}) async {
    emit(InvoicesHistoryLoading());
    _currentFilter = filter;

    try {
      // Fetch all invoices for this supplier
      final invoices =
          await (_db.select(_db.purchaseInvoices)
                ..where((t) => t.supplierId.equals(supplierId))
                ..orderBy([
                  (t) => OrderingTerm(
                    expression: t.invoiceDate,
                    mode: OrderingMode.desc,
                  ),
                ]))
              .get();

      // ✅ FIX: Use actual database paidAmount with null safety
      final invoicesWithStatus = invoices.map((invoice) {
        // Handle potential null values from old records (before column was added)
        final paidAmount = invoice.paidAmount ?? 0.0;
        final finalTotal = invoice.finalTotal;

        // Determine status based on actual payment
        InvoiceStatus status;
        if (paidAmount >= (finalTotal - 0.01)) {
          // Small margin for floating point comparison
          status = InvoiceStatus.complete;
        } else if (paidAmount == 0.0) {
          status = InvoiceStatus.unpaid;
        } else {
          status = InvoiceStatus.partial;
        }

        return InvoiceWithStatus(
          invoice: invoice,
          status: status,
          paidAmount: paidAmount,
        );
      }).toList();

      // Apply filter
      final filtered = _filterInvoices(invoicesWithStatus, filter);

      // Calculate total purchases
      final totalPurchases = invoices.fold(
        0.0,
        (sum, inv) => sum + inv.finalTotal,
      );

      emit(
        InvoicesHistoryLoaded(
          invoices: filtered,
          totalPurchases: totalPurchases,
          invoiceCount: invoices.length,
          currentFilter: filter,
        ),
      );
    } catch (e) {
      emit(InvoicesHistoryError('Failed to load invoices: ${e.toString()}'));
    }
  }

  List<InvoiceWithStatus> _filterInvoices(
    List<InvoiceWithStatus> invoices,
    String filter,
  ) {
    if (filter == 'all') return invoices;

    return invoices.where((inv) {
      switch (filter) {
        case 'unpaid':
          return inv.status == InvoiceStatus.unpaid;
        case 'partial':
          return inv.status == InvoiceStatus.partial;
        case 'complete':
          return inv.status == InvoiceStatus.complete;
        default:
          return true;
      }
    }).toList();
  }

  void applyFilter(String supplierId, String filter) {
    if (state is InvoicesHistoryLoaded) {
      loadInvoices(supplierId, filter: filter);
    }
  }

  Future<void> deleteInvoice(String invoiceId, String supplierId) async {
    try {
      await _inventoryRepository.deletePurchaseInvoice(invoiceId);
      // Reload the list to reflect changes
      loadInvoices(supplierId, filter: _currentFilter);
    } catch (e) {
      emit(InvoicesHistoryError('Failed to delete invoice: ${e.toString()}'));
    }
  }
}
