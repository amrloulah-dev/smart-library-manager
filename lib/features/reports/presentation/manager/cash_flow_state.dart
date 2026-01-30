part of 'cash_flow_cubit.dart';

abstract class CashFlowState extends Equatable {
  const CashFlowState();

  @override
  List<Object> get props => [];
}

class CashFlowInitial extends CashFlowState {}

class CashFlowLoading extends CashFlowState {}

class CashFlowLoaded extends CashFlowState {
  final List<CashFlowTransaction> transactions;
  final double totalIncome;
  final double totalExpense;
  final double netBalance;
  final CashFlowFilter activeFilter;

  const CashFlowLoaded({
    required this.transactions,
    required this.totalIncome,
    required this.totalExpense,
    required this.netBalance,
    required this.activeFilter,
  });

  @override
  List<Object> get props => [
    transactions,
    totalIncome,
    totalExpense,
    netBalance,
    activeFilter,
  ];
}

class CashFlowError extends CashFlowState {
  final String message;

  const CashFlowError(this.message);

  @override
  List<Object> get props => [message];
}
