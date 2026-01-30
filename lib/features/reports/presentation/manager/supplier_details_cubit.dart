import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/features/reports/domain/models/supplier_stats.dart';
import 'package:librarymanager/features/reports/domain/repositories/reports_repository.dart';

part 'supplier_details_state.dart';

@injectable
class SupplierDetailsCubit extends Cubit<SupplierDetailsState> {
  final ReportsRepository _reportsRepository;

  SupplierDetailsCubit(this._reportsRepository)
    : super(SupplierDetailsInitial());

  Future<void> loadSupplierStats(String supplierId) async {
    emit(SupplierDetailsLoading());
    try {
      final stats = await _reportsRepository.getSupplierStats(supplierId);
      emit(SupplierDetailsLoaded(stats));
    } catch (e) {
      emit(SupplierDetailsError(e.toString()));
    }
  }
}
