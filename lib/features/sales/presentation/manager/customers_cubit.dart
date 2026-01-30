import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/features/inventory/domain/repositories/inventory_repository.dart';
import 'customers_state.dart';

@injectable
class CustomersCubit extends Cubit<CustomersState> {
  final InventoryRepository _inventoryRepository;

  CustomersCubit(this._inventoryRepository) : super(CustomersInitial());

  Future<void> getCustomers() async {
    emit(CustomersLoading());
    try {
      // Use searchCustomers with empty query to get all
      final result = await _inventoryRepository.searchCustomers('');
      emit(CustomersLoaded(result));
    } catch (e) {
      emit(CustomersError(e.toString()));
    }
  }
}
