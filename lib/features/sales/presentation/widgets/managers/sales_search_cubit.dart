import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/features/inventory/domain/models/book_search_query.dart';
import 'package:librarymanager/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:librarymanager/features/sales/presentation/widgets/managers/sales_search_state.dart';
import 'package:librarymanager/core/database/app_database.dart';

@injectable
class SalesSearchCubit extends Cubit<SalesSearchState> {
  final InventoryRepository _inventoryRepository;

  SalesSearchCubit(this._inventoryRepository)
    : super(const SalesSearchState()) {
    _performSearch();
  }

  void updateQuery(String newQuery) {
    emit(state.copyWith(query: newQuery));
    _performSearch();
  }

  void updateFilters({
    String? publisher,
    String? subject,
    String? grade,
    String? term,
  }) {
    // If a value is passed as null, it means "no change" in copyWith usually,
    // but here if we pass null to updateFilters, does it mean clear or ignore?
    // Let's be explicit. We will accept nullable inputs and logic to handle "clearing" vs "setting".
    // Actually, the UI calls this when a dropdown changes. Dropdown returns `null` if cleared?
    // `FilterDropdown` returns the selected string. If it was cleared?
    // The current UI logic: `setState(() => selectedPublisher = val);`
    // So if val is passed, it overwrites.
    // For specific updates, I will create separate methods or use named params effectively.
    // Simpler: Just emit the new state with specific fields updated.

    // But wait, my copyWith logic: `selectedPublisher: selectedPublisher ?? this.selectedPublisher`.
    // If I pass null, it keeps old value.
    // I need to support "clearing".
    // I I'll rely on specific methods is safer.
  }

  void setPublisher(String? val) {
    emit(state.copyWith(selectedPublisher: val, clearPublisher: val == null));
    _performSearch();
  }

  void setSubject(String? val) {
    emit(state.copyWith(selectedSubject: val, clearSubject: val == null));
    _performSearch();
  }

  void setGrade(String? val) {
    emit(state.copyWith(selectedGrade: val, clearGrade: val == null));
    _performSearch();
  }

  void setTerm(String? val) {
    emit(state.copyWith(selectedTerm: val, clearTerm: val == null));
    _performSearch();
  }

  void clearFilters() {
    emit(
      state.copyWith(
        clearPublisher: true,
        clearSubject: true,
        clearGrade: true,
        clearTerm: true,
      ),
    );
    _performSearch();
  }

  Future<void> _performSearch() async {
    emit(state.copyWith(isLoading: true));

    try {
      final queryObj = BookSearchQuery(
        publisher: state.selectedPublisher,
        subject: state.selectedSubject,
        grade: state.selectedGrade,
        term: state.selectedTerm,
      );

      final results = await _inventoryRepository.findBookByAttributes(queryObj);

      List<Book> filteredResults = results;
      if (state.query.isNotEmpty) {
        final lowerQuery = state.query.toLowerCase();
        filteredResults = results.where((book) {
          return book.name.toLowerCase().contains(lowerQuery) ||
              (book.publisher?.toLowerCase().contains(lowerQuery) ?? false) ||
              (book.searchKeywords?.toLowerCase().contains(lowerQuery) ??
                  false);
        }).toList();
      }

      emit(state.copyWith(isLoading: false, results: filteredResults));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
