part of 'detailed_reports_cubit.dart';

abstract class DetailedReportsState extends Equatable {
  const DetailedReportsState();

  @override
  List<Object> get props => [];
}

class DetailedReportsInitial extends DetailedReportsState {}

class DetailedReportsLoading extends DetailedReportsState {}

class DetailedReportsLoaded extends DetailedReportsState {
  final List<DailySalesPoint> chartData;
  final FinancialReport financialReport;
  final DateTimeRange range;

  const DetailedReportsLoaded({
    required this.chartData,
    required this.financialReport,
    required this.range,
  });

  @override
  List<Object> get props => [chartData, financialReport, range];
}

class DetailedReportsError extends DetailedReportsState {
  final String message;

  const DetailedReportsError(this.message);

  @override
  List<Object> get props => [message];
}
