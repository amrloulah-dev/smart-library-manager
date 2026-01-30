import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/reports/domain/repositories/reports_repository.dart';

part 'dashboard_state.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  final ReportsRepository _reportsRepository;

  DashboardCubit(this._reportsRepository) : super(DashboardInitial());

  StreamSubscription? _statsSubscription;

  @override
  Future<void> close() {
    _statsSubscription?.cancel();
    return super.close();
  }

  void loadDashboardStats() {
    // Show loading only on initial load
    if (state is DashboardInitial) {
      emit(DashboardLoading());
    }

    _statsSubscription?.cancel();
    _statsSubscription = _reportsRepository.getDashboardStatsStream().listen(
      (stats) {
        if (!isClosed) emit(DashboardLoaded(stats));
      },
      onError: (e) {
        if (!isClosed) emit(DashboardError(e.toString()));
      },
    );
  }

  Future<List<Book>> getLowStockBooks() {
    return _reportsRepository.getLowStockBooks();
  }

  String get aiInsightText {
    if (state is DashboardLoaded) {
      return (state as DashboardLoaded).stats.aiInsight;
    }
    return 'جاري تحليل البيانات...';
  }
}
