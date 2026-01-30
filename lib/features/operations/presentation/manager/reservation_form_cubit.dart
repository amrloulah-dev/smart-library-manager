import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/inventory/domain/repositories/inventory_repository.dart';
import 'reservation_form_state.dart';

@injectable
class ReservationFormCubit extends Cubit<ReservationFormState> {
  final InventoryRepository _inventoryRepository;

  ReservationFormCubit(this._inventoryRepository)
    : super(const ReservationFormState());

  Future<void> searchBooks(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(searchResults: [], isSearching: false));
      return;
    }

    emit(state.copyWith(isSearching: true));

    try {
      final allBooks = await _inventoryRepository.streamAllBooks().first;
      final filtered = allBooks
          .where(
            (book) => book.name.toLowerCase().contains(query.toLowerCase()),
          )
          .take(5)
          .toList();

      emit(state.copyWith(searchResults: filtered, isSearching: false));
    } catch (e) {
      emit(state.copyWith(searchResults: [], isSearching: false));
    }
  }

  void selectBook(Book book) {
    emit(state.copyWith(selectedBook: book, searchResults: []));
  }

  void clearSelection() {
    emit(
      const ReservationFormState().copyWith(
        customerName: state.customerName,
        phone: state.phone,
        deposit: state.deposit,
      ),
    );
    // Essentially clearing book and results but keeping form data
  }

  void updateName(String name) {
    emit(state.copyWith(customerName: name));
  }

  void updatePhone(String phone) {
    emit(state.copyWith(phone: phone));
  }

  void updateDeposit(String value) {
    final deposit = double.tryParse(value) ?? 0.0;
    emit(state.copyWith(deposit: deposit));
  }
}
