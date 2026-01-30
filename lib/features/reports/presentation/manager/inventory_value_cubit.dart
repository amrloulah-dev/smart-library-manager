import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/features/reports/domain/repositories/reports_repository.dart';
import 'inventory_value_state.dart';

@injectable
class InventoryValueCubit extends Cubit<InventoryValueState> {
  final ReportsRepository _reportsRepository;

  InventoryValueCubit(this._reportsRepository) : super(InventoryValueInitial());

  Future<void> loadInventoryValue() async {
    emit(InventoryValueLoading());
    try {
      final value = await _reportsRepository.getTotalInventoryValue();
      emit(InventoryValueLoaded(value));
    } catch (e) {
      emit(InventoryValueError(e.toString()));
    }
  }
}
