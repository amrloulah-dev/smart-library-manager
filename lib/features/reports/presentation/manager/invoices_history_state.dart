part of 'invoices_history_cubit.dart';

abstract class InvoicesHistoryState extends Equatable {
  const InvoicesHistoryState();

  @override
  List<Object> get props => [];
}

class InvoicesHistoryInitial extends InvoicesHistoryState {}

class InvoicesHistoryLoading extends InvoicesHistoryState {}

class InvoicesHistoryLoaded extends InvoicesHistoryState {
  final List<InvoiceWithStatus> invoices;
  final double totalPurchases;
  final int invoiceCount;
  final String currentFilter;

  const InvoicesHistoryLoaded({
    required this.invoices,
    required this.totalPurchases,
    required this.invoiceCount,
    required this.currentFilter,
  });

  @override
  List<Object> get props => [
    invoices,
    totalPurchases,
    invoiceCount,
    currentFilter,
  ];
}

class InvoicesHistoryError extends InvoicesHistoryState {
  final String message;

  const InvoicesHistoryError(this.message);

  @override
  List<Object> get props => [message];
}
