import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/features/operations/domain/repositories/expenses_repository.dart';
import 'package:librarymanager/features/reports/data/models/cash_flow_transaction.dart';
import 'package:librarymanager/features/sales/domain/repositories/sales_repository.dart';

part 'cash_flow_state.dart';

enum CashFlowFilter { day, week, month, custom }

@injectable
class CashFlowCubit extends Cubit<CashFlowState> {
  final SalesRepository _salesRepository;
  final ExpensesRepository _expensesRepository;

  StreamSubscription? _salesSub;

  CashFlowCubit(this._salesRepository, this._expensesRepository)
    : super(CashFlowInitial()) {
    // Load initial data
    fetchTransactions(CashFlowFilter.day);
  }

  @override
  Future<void> close() {
    _salesSub?.cancel();
    return super.close();
  }

  void fetchTransactions(CashFlowFilter filter, {DateTimeRange? customRange}) {
    emit(CashFlowLoading());

    _salesSub?.cancel();
    _salesSub = _salesRepository.streamSalesHistory().listen(
      (sales) async {
        try {
          // Determine date range
          final now = DateTime.now();
          DateTime startDate;
          DateTime endDate = now; // Default end date is now

          switch (filter) {
            case CashFlowFilter.day:
              startDate = DateTime(now.year, now.month, now.day);
              break;
            case CashFlowFilter.week:
              startDate = now.subtract(const Duration(days: 7));
              break;
            case CashFlowFilter.month:
              startDate = DateTime(now.year, now.month, 1);
              break;
            case CashFlowFilter.custom:
              if (customRange != null) {
                startDate = customRange.start;
                endDate = customRange.end;
              } else {
                // Fallback if null
                startDate = DateTime(now.year, now.month, now.day);
              }
              break;
          }

          final filteredSales = sales
              .where(
                (s) =>
                    s.saleDate.isAfter(startDate) &&
                    s.saleDate.isBefore(endDate.add(const Duration(days: 1))),
              )
              .map(
                (s) => CashFlowTransaction(
                  id: s.id.toString(),
                  title: 'عملية بيع #${s.id}',
                  subtitle: 'مبيعات نقدية',
                  amount: s.totalAmount,
                  date: s.saleDate,
                  type: TransactionType.income,
                  category: 'sale',
                ),
              );

          // Fetch Expenses (Expense)
          // Ideally this should be a stream too, but for now we await it on every sale update.
          final expenses = await _expensesRepository.getExpenses();
          final filteredExpenses = expenses
              .where(
                (e) =>
                    e.date.isAfter(startDate) &&
                    e.date.isBefore(endDate.add(const Duration(days: 1))),
              )
              .map(
                (e) => CashFlowTransaction(
                  id: e.id.toString(),
                  title: e.title.isNotEmpty ? e.title : e.category,
                  subtitle: e.category,
                  amount: e.amount,
                  date: e.date,
                  type: TransactionType.expense,
                  category: 'expense',
                ),
              );

          // Merge and Sort
          final allTransactions = [...filteredSales, ...filteredExpenses]
            ..sort((a, b) => b.date.compareTo(a.date));

          // Calculate Totals
          double totalIncome = 0;
          double totalExpense = 0;

          for (var t in allTransactions) {
            if (t.type == TransactionType.income) {
              totalIncome += t.amount;
            } else {
              totalExpense += t.amount;
            }
          }

          if (!isClosed) {
            emit(
              CashFlowLoaded(
                transactions: allTransactions,
                totalIncome: totalIncome,
                totalExpense: totalExpense,
                netBalance: totalIncome - totalExpense,
                activeFilter: filter,
              ),
            );
          }
        } catch (e) {
          if (!isClosed) emit(CashFlowError(e.toString()));
        }
      },
      onError: (e) {
        if (!isClosed) emit(CashFlowError(e.toString()));
      },
    );
  }
}
