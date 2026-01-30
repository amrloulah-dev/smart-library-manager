import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';

part 'expenses_dao.g.dart';

@lazySingleton
@DriftAccessor(tables: [Expenses])
class ExpensesDao extends DatabaseAccessor<AppDatabase>
    with _$ExpensesDaoMixin {
  ExpensesDao(super.db);

  Future<void> addExpense(ExpensesCompanion expense) {
    return into(expenses).insert(expense);
  }

  Stream<List<Expense>> streamExpenses() {
    return (select(expenses)..orderBy([
          (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
        ]))
        .watch();
  }

  Future<List<Expense>> getExpensesByDateRange(DateTime start, DateTime end) {
    return (select(expenses)
          ..where((t) => t.date.isBetween(Variable(start), Variable(end)))
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
          ]))
        .get();
  }

  Future<List<Expense>> getExpenses() {
    return (select(expenses)
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
          ])
          ..limit(100))
        .get();
  }

  /// Get total expenses amount for a specific date range using SQL aggregation
  Future<double> getExpensesTotalForDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final query = selectOnly(expenses)..addColumns([expenses.amount.sum()]);
    query.where(expenses.date.isBetween(Variable(start), Variable(end)));
    final result = await query.getSingleOrNull();
    return result?.read(expenses.amount.sum()) ?? 0.0;
  }
}
