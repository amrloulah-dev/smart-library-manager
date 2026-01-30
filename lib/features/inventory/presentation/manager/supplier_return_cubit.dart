import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:librarymanager/app/injection.dart';
import 'package:librarymanager/core/services/supabase_sync_service.dart';

part 'supplier_return_state.dart';

@injectable
class SupplierReturnCubit extends Cubit<SupplierReturnState> {
  final InventoryRepository _inventoryRepository;

  SupplierReturnCubit(this._inventoryRepository)
    : super(SupplierReturnInitial());

  Future<void> loadBooksForSupplier(String supplierId) async {
    try {
      emit(SupplierReturnLoading());
      // Ideally we should filter by supplierId.
      // But currently streamAllBooks returns mostly everything?
      // Wait, InventoryRepository streamAllBooks returns Stream<List<Book>>.
      // We need a Future list here.
      // And ideally filtered.
      // Since the requirement says "Fetch books (currently we fetch all, filtering by supplier logic can be simulated or fetched all for now)."
      // I will fetch all and filter in memory if "supplierId" logic was present in Book, but Book doesn't seem to have supplierId directly on it from what I saw earlier (it was created from PurchaseInvoice).
      // If Book doesn't have a direct link to Supplier (many-to-many via PurchaseItems), finding "books for supplier" is hard without a specific query.
      // "currently we fetch all ... simulated".
      // So I will just fetch existing books.
      // I'll use the stream as a future for one-shot load.
      final booksStream = _inventoryRepository.streamAllBooks();
      final books = await booksStream.first;

      // Simulation: Filter? Book doesn't have supplierId column shown in earlier viewing (it had: id, name, costPrice, sellPrice, currentStock, etc.)
      // So checking "supplierId" is impossible on Book unless we join with PurchaseItems.
      // I will return ALL books for now as per "fetch all ... can be simulated".

      emit(SupplierReturnLoaded(books));
    } catch (e) {
      emit(SupplierReturnError('Failed to load books: $e'));
    }
  }

  Future<void> executeReturn(
    String supplierId,
    Map<Book, int> itemsToReturn,
    double discountPercentage,
  ) async {
    try {
      if (itemsToReturn.isEmpty) {
        emit(const SupplierReturnError('لم يتم اختيار كتب للارتجاع.'));
        return;
      }

      emit(SupplierReturnLoading());

      await _inventoryRepository.processSupplierReturn(
        supplierId,
        itemsToReturn,
        discountPercentage,
      );

      emit(const SupplierReturnSuccess('تمت عملية الارتجاع بنجاح.'));

      // Trigger Sync
      Future.delayed(const Duration(seconds: 1), () {
        getIt<SupabaseSyncService>().syncPendingData();
      });
    } catch (e) {
      emit(SupplierReturnError(e.toString()));
    }
  }

  Future<void> executeReturnWithIds(
    String supplierId,
    Map<String, int> itemIds,
    double discountPercentage,
  ) async {
    try {
      if (itemIds.isEmpty) {
        emit(const SupplierReturnError('لم يتم اختيار كتب للارتجاع.'));
        return;
      }

      emit(SupplierReturnLoading());

      // 1. Fetch current books by IDs to get costPrice
      final bookListStream = _inventoryRepository.streamAllBooks();
      final allBooks = await bookListStream.first;

      final Map<Book, int> itemsToReturn = {};
      for (final id in itemIds.keys) {
        final book = allBooks.firstWhere((b) => b.id == id);
        itemsToReturn[book] = itemIds[id]!;
      }

      await _inventoryRepository.processSupplierReturn(
        supplierId,
        itemsToReturn,
        discountPercentage,
      );

      emit(const SupplierReturnSuccess('تمت عملية الارتجاع بنجاح.'));

      // Trigger Sync
      Future.delayed(const Duration(seconds: 1), () {
        getIt<SupabaseSyncService>().syncPendingData();
      });
    } catch (e) {
      emit(SupplierReturnError(e.toString()));
    }
  }
}
