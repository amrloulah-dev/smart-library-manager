import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/features/reports/domain/models/invoice_detail_model.dart';
import 'package:librarymanager/features/reports/domain/repositories/reports_repository.dart';
import 'package:librarymanager/features/inventory/domain/repositories/inventory_repository.dart';

part 'invoice_details_state.dart';

@injectable
class InvoiceDetailsCubit extends Cubit<InvoiceDetailsState> {
  final ReportsRepository _reportsRepository;
  final InventoryRepository _inventoryRepository;

  InvoiceDetailsCubit(this._reportsRepository, this._inventoryRepository)
    : super(InvoiceDetailsInitial());

  Future<void> loadInvoice(String invoiceId) async {
    emit(InvoiceDetailsLoading());
    try {
      final details = await _reportsRepository.getInvoiceDetails(invoiceId);
      emit(InvoiceDetailsLoaded(details));
    } catch (e) {
      emit(InvoiceDetailsError(e.toString()));
    }
  }

  Future<void> deleteInvoice(String invoiceId) async {
    try {
      await _inventoryRepository.deletePurchaseInvoice(invoiceId);
      emit(InvoiceDeletedSuccess());
    } catch (e) {
      emit(InvoiceDetailsError(e.toString()));
    }
  }
}
