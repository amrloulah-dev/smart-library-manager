import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/features/inventory/domain/repositories/inventory_repository.dart';
import 'book_search_state.dart';

@injectable
class BookSearchCubit extends Cubit<BookSearchState> {
  final InventoryRepository _repository;

  BookSearchCubit(this._repository) : super(const BookSearchState());

  Future<void> search(String query) async {
    if (query.isEmpty) {
      emit(const BookSearchState(results: [], isSearching: false));
      return;
    }

    emit(const BookSearchState(results: [], isSearching: true));

    try {
      final allBooks = await _repository.streamAllBooks().first;
      final results = allBooks
          .where((b) => b.name.toLowerCase().contains(query.toLowerCase()))
          .take(20)
          .toList();
      emit(BookSearchState(results: results, isSearching: false));
    } catch (e) {
      emit(const BookSearchState(results: [], isSearching: false));
    }
  }
}
