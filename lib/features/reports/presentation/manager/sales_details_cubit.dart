import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/database/daos/sales_dao.dart';

part 'sales_details_state.dart';

@injectable
class SalesDetailsCubit extends Cubit<SalesDetailsState> {
  final SalesDao _salesDao;

  // Track current date range
  DateTimeRange? _currentRange;

  SalesDetailsCubit(this._salesDao) : super(SalesDetailsInitial());

  /// Get formatted date label for display
  String get dateLabel {
    if (_currentRange == null) {
      return DateFormat('d MMM yyyy', 'ar').format(DateTime.now());
    }

    final startStr = DateFormat('d MMM', 'ar').format(_currentRange!.start);
    final endStr = DateFormat('d MMM yyyy', 'ar').format(_currentRange!.end);

    // Check if same day
    if (_currentRange!.start.year == _currentRange!.end.year &&
        _currentRange!.start.month == _currentRange!.end.month &&
        _currentRange!.start.day == _currentRange!.end.day) {
      return DateFormat('d MMM yyyy', 'ar').format(_currentRange!.start);
    }

    return '$startStr - $endStr';
  }

  StreamSubscription? _salesSubscription;

  @override
  Future<void> close() {
    _salesSubscription?.cancel();
    return super.close();
  }

  void fetchSalesData({DateTimeRange? range}) {
    emit(SalesDetailsLoading());
    // Update current range
    _currentRange = range;

    _salesSubscription?.cancel();
    _salesSubscription = _salesDao.streamAllSales().listen(
      (allSales) {
        try {
          // Get date range (default to today if null)
          final now = DateTime.now();
          final startDate =
              range?.start ?? DateTime(now.year, now.month, now.day);
          final endDate =
              range?.end ?? DateTime(now.year, now.month, now.day, 23, 59, 59);

          // Filter for selected period
          final periodSales = allSales.where((s) {
            return s.saleDate.isAfter(startDate) &&
                s.saleDate.isBefore(endDate.add(const Duration(days: 1)));
          }).toList();

          // Calculate totals
          double totalPeriod = 0;
          double cashSales = 0;
          double creditSales = 0;

          for (var sale in periodSales) {
            totalPeriod += sale.totalAmount;
            final pType = sale.paymentType.toLowerCase();
            if (pType.contains('cash') || pType.contains('نقدي')) {
              cashSales += sale.totalAmount;
            } else {
              creditSales += sale.totalAmount;
            }
          }

          // Calculate improvement vs previous period
          final periodDuration = endDate.difference(startDate);
          final previousStart = startDate.subtract(periodDuration);
          final previousEnd = startDate.subtract(const Duration(seconds: 1));

          final previousPeriodSales = allSales.where((s) {
            return s.saleDate.isAfter(previousStart) &&
                s.saleDate.isBefore(previousEnd.add(const Duration(days: 1)));
          }).toList();

          double totalPrevious = previousPeriodSales.fold(
            0.0,
            (sum, item) => sum + item.totalAmount,
          );

          double improvement = 0;
          if (totalPrevious > 0) {
            improvement = ((totalPeriod - totalPrevious) / totalPrevious) * 100;
          } else if (totalPeriod > 0) {
            improvement = 100;
          }

          // Recent sales from the selected period (last 5)
          periodSales.sort((a, b) => b.saleDate.compareTo(a.saleDate));
          final recentSales = periodSales.take(5).toList();

          emit(
            SalesDetailsLoaded(
              totalDailySales: totalPeriod,
              cashSales: cashSales,
              creditSales: creditSales,
              dailyImprovement: improvement,
              recentTransactions: recentSales,
            ),
          );
        } catch (e) {
          emit(SalesDetailsError('Failed to fetch sales: ${e.toString()}'));
        }
      },
      onError: (e) {
        emit(SalesDetailsError('Failed to fetch sales: ${e.toString()}'));
      },
    );
  }
}
