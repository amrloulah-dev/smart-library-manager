import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/sales/domain/repositories/sales_repository.dart';

part 'exchange_state.dart';

@injectable
class ExchangeCubit extends Cubit<ExchangeState> {
  final SalesRepository _salesRepository;

  ExchangeCubit(this._salesRepository) : super(const ExchangeState());

  void addReturnedItem(Book book) {
    final updatedList = List<Book>.from(state.returnedItems)..add(book);
    emit(state.copyWith(returnedItems: updatedList));
  }

  void removeReturnedItem(Book book) {
    final updatedList = List<Book>.from(state.returnedItems)..remove(book);
    emit(state.copyWith(returnedItems: updatedList));
  }

  void addNewItem(Book book) {
    final updatedList = List<Book>.from(state.newItems)..add(book);
    emit(state.copyWith(newItems: updatedList));
  }

  void removeNewItem(Book book) {
    final updatedList = List<Book>.from(state.newItems)..remove(book);
    emit(state.copyWith(newItems: updatedList));
  }

  Future<void> confirmExchange() async {
    if (state.returnedItems.isEmpty && state.newItems.isEmpty) {
      return;
    }

    emit(state.copyWith(status: ExchangeStatus.loading));

    try {
      await _salesRepository.processExchange(
        returnedItems: state.returnedItems,
        newItems: state.newItems,
      );
      emit(state.copyWith(status: ExchangeStatus.success));
      // Clear state after success?
      emit(const ExchangeState(status: ExchangeStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: ExchangeStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
