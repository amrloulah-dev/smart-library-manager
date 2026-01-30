import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/utils/text_normalizer.dart';
import 'package:librarymanager/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:librarymanager/features/reports/domain/models/item_history_model.dart';

// States
abstract class ItemHistoryState {}

class ItemHistoryInitial extends ItemHistoryState {}

class ItemHistoryLoading extends ItemHistoryState {}

class ItemHistoryLoaded extends ItemHistoryState {
  final List<ItemMovementEvent> events;
  final ItemStats stats;

  ItemHistoryLoaded(this.events, this.stats);
}

class ItemHistoryError extends ItemHistoryState {
  final String message;
  ItemHistoryError(this.message);
}

class ItemHistoryDeleted extends ItemHistoryState {}

class ItemHistoryUpdated extends ItemHistoryState {}

@injectable
class ItemHistoryCubit extends Cubit<ItemHistoryState> {
  final InventoryRepository _repository;

  ItemHistoryCubit(this._repository) : super(ItemHistoryInitial());

  Future<void> loadHistory(String bookId) async {
    emit(ItemHistoryLoading());
    try {
      final result = await _repository.getItemHistory(bookId);
      emit(ItemHistoryLoaded(result.events, result.stats));
    } catch (e) {
      emit(ItemHistoryError('Failed to load item history: $e'));
    }
  }

  Future<void> deleteBook(String bookId) async {
    try {
      await _repository.deleteBook(bookId);
      emit(ItemHistoryDeleted());
    } catch (e) {
      emit(ItemHistoryError('Failed to delete book: $e'));
    }
  }

  Future<void> updateBook({
    required String id,
    required String name,
    required int quantity,
    required double costPrice,
    required double sellPrice,
  }) async {
    try {
      final normalizedName = TextNormalizer.standardizeBookName(name);

      final companion = BooksCompanion(
        id: Value(id),
        name: Value(normalizedName),
        currentStock: Value(quantity),
        costPrice: Value(costPrice),
        sellPrice: Value(sellPrice),
        isSynced: const Value(false), // Mark for sync
      );

      await _repository.updateBookDetails(companion);

      // Emit success state to trigger navigation
      emit(ItemHistoryUpdated());

      // Reload to show updates (Optional if we pop, but good for safety)
      // await loadHistory(id);
    } catch (e) {
      emit(ItemHistoryError('Failed to update book: $e'));
    }
  }
}
