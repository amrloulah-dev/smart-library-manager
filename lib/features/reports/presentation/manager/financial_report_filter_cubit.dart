import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

class FinancialReportFilterState extends Equatable {
  final bool isRangeMode;
  final DateTimeRange selectedRange;

  const FinancialReportFilterState({
    this.isRangeMode = false,
    required this.selectedRange,
  });

  FinancialReportFilterState copyWith({
    bool? isRangeMode,
    DateTimeRange? selectedRange,
  }) {
    return FinancialReportFilterState(
      isRangeMode: isRangeMode ?? this.isRangeMode,
      selectedRange: selectedRange ?? this.selectedRange,
    );
  }

  @override
  List<Object> get props => [isRangeMode, selectedRange];
}

@injectable
class FinancialReportFilterCubit extends Cubit<FinancialReportFilterState> {
  FinancialReportFilterCubit()
    : super(
        FinancialReportFilterState(
          selectedRange: DateTimeRange(
            start: DateTime.now().subtract(const Duration(days: 7)),
            end: DateTime.now(),
          ),
        ),
      );

  void setRangeMode(bool isRangeMode) {
    emit(state.copyWith(isRangeMode: isRangeMode));
  }

  void updateRange(DateTimeRange range) {
    emit(state.copyWith(selectedRange: range, isRangeMode: true));
  }
}
