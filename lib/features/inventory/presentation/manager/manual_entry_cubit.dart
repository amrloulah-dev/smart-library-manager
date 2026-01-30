import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/inventory/presentation/manager/manual_entry_state.dart';
import 'package:librarymanager/features/inventory/domain/repositories/inventory_repository.dart';
import '../../../../core/utils/text_normalizer.dart';
import 'package:librarymanager/app/injection.dart';
import 'package:librarymanager/core/services/supabase_sync_service.dart';

@injectable
class ManualEntryCubit extends Cubit<ManualEntryState> {
  final InventoryRepository _inventoryRepository;

  ManualEntryCubit(this._inventoryRepository) : super(const ManualEntryState());

  void updatePublisher(String? value) {
    emit(state.copyWith(publisher: value));
    _generateNameAndCheck();
  }

  void updateSubject(String? value) {
    emit(state.copyWith(subject: value));
    _generateNameAndCheck();
  }

  void updateGrade(String? value) {
    emit(state.copyWith(grade: value));
    _generateNameAndCheck();
  }

  void updateTerm(String? value) {
    emit(state.copyWith(term: value));
    _generateNameAndCheck();
  }

  void updateQuantity(String value) {
    final qty = int.tryParse(value) ?? 0;
    emit(state.copyWith(quantity: qty));
  }

  void updateCostPrice(String value) {
    final price = double.tryParse(value) ?? 0.0;
    emit(state.copyWith(costPrice: price));
  }

  void updateSellPrice(String value) {
    final price = double.tryParse(value) ?? 0.0;
    emit(state.copyWith(sellPrice: price));
  }

  Future<void> _generateNameAndCheck() async {
    final parts = [
      state.publisher,
      state.subject,
      state.grade,
      state.term,
    ].where((part) => part != null && part.isNotEmpty).toList();

    final rawName = parts.join(' ');
    final name = TextNormalizer.standardizeBookName(rawName);
    emit(state.copyWith(generatedName: name));

    if (name.isNotEmpty) {
      final book = await _inventoryRepository.findBookByName(name);
      if (book != null) {
        // If found, pre-fill prices if they are 0?
        // Maybe useful to show current price.
        // For now just set existingBook
        emit(
          state.copyWith(
            existingBook: book,
            costPrice: state.costPrice == 0 ? book.costPrice : state.costPrice,
            sellPrice: state.sellPrice == 0 ? book.sellPrice : state.sellPrice,
          ),
        );
      } else {
        emit(state.copyWith(clearExistingBook: true));
      }
    } else {
      emit(state.copyWith(clearExistingBook: true));
    }
  }

  Future<void> submitBook(String sellPriceText) async {
    if (state.generatedName.isEmpty) {
      emit(
        state.copyWith(
          status: ManualEntryStatus.failure,
          errorMessage: 'Generated name is empty',
        ),
      );
      return;
    }

    final double sellPrice = double.tryParse(sellPriceText) ?? 0.0;

    emit(
      state.copyWith(status: ManualEntryStatus.loading, sellPrice: sellPrice),
    );

    try {
      if (state.existingBook != null) {
        // Update stock
        await _inventoryRepository.updateBookStock(
          state.existingBook!.id,
          state.quantity,
        );
        // Note: For now we only update stock in existing books per repo design
      } else {
        // Insert new book
        final book = BooksCompanion(
          name: Value(state.generatedName),
          costPrice: Value(state.costPrice),
          sellPrice: Value(sellPrice),
          currentStock: Value(state.quantity),
          minLimit: const Value(5),
          totalSoldQty: const Value(0),
          reservedQuantity: const Value(0),
        );
        await _inventoryRepository.insertBook(book);
      }

      // Trigger Offline Sync
      getIt<SupabaseSyncService>().syncPendingData();

      emit(state.copyWith(status: ManualEntryStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: ManualEntryStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void resetStatus() {
    emit(state.copyWith(status: ManualEntryStatus.initial));
  }
}
