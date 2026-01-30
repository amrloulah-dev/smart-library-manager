part of 'suppliers_report_cubit.dart';

abstract class SuppliersReportState extends Equatable {
  const SuppliersReportState();

  @override
  List<Object> get props => [];
}

class SuppliersReportInitial extends SuppliersReportState {}

class SuppliersReportLoading extends SuppliersReportState {}

class SuppliersReportLoaded extends SuppliersReportState {
  final List<SupplierReportModel> suppliers;
  final double totalDebt;
  final double totalPaidToSuppliers;

  const SuppliersReportLoaded({
    required this.suppliers,
    required this.totalDebt,
    required this.totalPaidToSuppliers,
  });

  @override
  List<Object> get props => [suppliers, totalDebt, totalPaidToSuppliers];
}

class SuppliersReportError extends SuppliersReportState {
  final String message;

  const SuppliersReportError(this.message);

  @override
  List<Object> get props => [message];
}
