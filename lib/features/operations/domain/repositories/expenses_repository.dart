import 'package:librarymanager/core/database/app_database.dart';

abstract class ExpensesRepository {
  Stream<List<Expense>> streamExpenses();
  Future<void> addExpense({
    required String title,
    required double amount,
    required String category,
    required DateTime date,
    String? notes,
  });
  Future<List<Expense>> getExpenses();
  Future<List<Expense>> getExpensesByDateRange(DateTime start, DateTime end);
}
