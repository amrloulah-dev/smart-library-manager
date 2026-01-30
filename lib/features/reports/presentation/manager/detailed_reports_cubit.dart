import 'dart:async'; // Added
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/features/reports/domain/models/financial_report.dart';
import 'package:librarymanager/features/reports/domain/repositories/reports_repository.dart';

part 'detailed_reports_state.dart';

@injectable
class DetailedReportsCubit extends Cubit<DetailedReportsState> {
  final ReportsRepository _reportsRepository;
  StreamSubscription? _reportSubscription;

  DetailedReportsCubit(this._reportsRepository)
    : super(DetailedReportsInitial());

  @override
  Future<void> close() {
    _reportSubscription?.cancel();
    return super.close();
  }

  Future<void> fetchReport(DateTimeRange range) async {
    emit(DetailedReportsLoading());

    final start = range.start;
    final end = range.end
        .add(const Duration(days: 1))
        .subtract(const Duration(seconds: 1)); // End of day

    _reportSubscription?.cancel();
    _reportSubscription = _reportsRepository
        .getFinancialReportStream(start, end)
        .listen(
          (financialReport) async {
            if (isClosed) return;
            try {
              // Fetch chart data as well to ensure it stays in sync with financial report
              final chartData = await _reportsRepository.getSalesChartData(
                start,
                end,
              );

              emit(
                DetailedReportsLoaded(
                  chartData: chartData,
                  financialReport: financialReport,
                  range: range,
                ),
              );
            } catch (e) {
              if (!isClosed) emit(DetailedReportsError(e.toString()));
            }
          },
          onError: (e) {
            if (!isClosed) emit(DetailedReportsError(e.toString()));
          },
        );
  }

  void fetchAllTime() {
    final now = DateTime.now();
    final start = DateTime(2000); // Start from beginning
    fetchReport(DateTimeRange(start: start, end: now));
  }

  void fetchToday() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    fetchReport(DateTimeRange(start: start, end: start));
  }

  void fetchWeek() {
    final now = DateTime.now();
    final start = now.subtract(Duration(days: now.weekday - 1));
    final startOfWeek = DateTime(start.year, start.month, start.day);
    fetchReport(DateTimeRange(start: startOfWeek, end: now));
  }

  void fetchMonth() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, 1);
    fetchReport(DateTimeRange(start: start, end: now));
  }
}
