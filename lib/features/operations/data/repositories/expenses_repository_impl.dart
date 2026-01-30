import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/database/daos/expenses_dao.dart';
import 'package:librarymanager/features/operations/domain/repositories/expenses_repository.dart';

@LazySingleton(as: ExpensesRepository)
class ExpensesRepositoryImpl implements ExpensesRepository {
  final ExpensesDao _expensesDao;

  ExpensesRepositoryImpl(this._expensesDao);

  @override
  Stream<List<Expense>> streamExpenses() {
    return _expensesDao.streamExpenses();
  }

  @override
  Future<void> addExpense({
    required String title,
    required double amount,
    required String category,
    required DateTime date,
    String? notes,
  }) {
    return _expensesDao.addExpense(
      ExpensesCompanion(
        title: Value(title),
        amount: Value(amount),
        category: Value(category),
        date: Value(date),
        userNotes: notes != null ? Value(notes) : const Value.absent(),
      ),
    );
  }

  @override
  Future<List<Expense>> getExpensesByDateRange(DateTime start, DateTime end) {
    return _expensesDao.getExpensesByDateRange(start, end);
  }

  @override
  Future<List<Expense>> getExpenses() {
    return _expensesDao.getExpenses();
  }
}
