import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/features/reports/domain/models/supplier_report_model.dart';
import 'package:librarymanager/features/reports/domain/repositories/reports_repository.dart';

part 'suppliers_report_state.dart';

@injectable
class SuppliersReportCubit extends Cubit<SuppliersReportState> {
  final ReportsRepository _reportsRepository;
  StreamSubscription? _suppliersSubscription;

  SuppliersReportCubit(this._reportsRepository)
    : super(SuppliersReportInitial());

  @override
  Future<void> close() {
    _suppliersSubscription?.cancel();
    return super.close();
  }

  void loadSuppliersReport() {
    // Show loading only on initial load
    if (state is SuppliersReportInitial) {
      emit(SuppliersReportLoading());
    }

    _suppliersSubscription?.cancel();
    _suppliersSubscription = _reportsRepository.getSuppliersReportStream().listen(
      (suppliers) async {
        if (isClosed) return;

        // Sort by balance descending (Debt)
        suppliers.sort((a, b) => b.balance.compareTo(a.balance));

        final reportList = suppliers.map((supplier) {
          final score = supplier.aiScore ?? 5.0; // Default to 5.0 if null

          InsightType type = InsightType.none;
          String? message;

          if (score < 3.0) {
            type = InsightType.negative;
            message = 'مورد خطر، يُنصح وتقليل التعامل ومراجعة الديون.';
          } else if (score >= 4.0) {
            type = InsightType.positive;
            message = 'مورد ممتاز، ينصح بزيادة التعامل معه.';
          }

          return SupplierReportModel(
            supplier: supplier,
            insightType: type,
            insightMessage: message,
          );
        }).toList();

        final totalDebt = suppliers.fold(0.0, (sum, s) => sum + s.balance);

        // FIX: Use the repository method to calculate Total Paid (Invoices + Payments)
        final totalPaid = await _reportsRepository.getTotalPaidToSuppliers();

        if (isClosed) return;

        emit(
          SuppliersReportLoaded(
            suppliers: reportList,
            totalDebt: totalDebt,
            totalPaidToSuppliers: totalPaid,
          ),
        );
      },
      onError: (e) {
        if (!isClosed) emit(SuppliersReportError(e.toString()));
      },
    );
  }
}
