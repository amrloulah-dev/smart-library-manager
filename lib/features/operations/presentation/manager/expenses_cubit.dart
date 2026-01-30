import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/operations/domain/repositories/expenses_repository.dart';
import 'package:librarymanager/app/injection.dart';
import 'package:librarymanager/core/services/supabase_sync_service.dart';

part 'expenses_state.dart';

@injectable
class ExpensesCubit extends Cubit<ExpensesState> {
  final ExpensesRepository _expensesRepository;

  ExpensesCubit(this._expensesRepository) : super(ExpensesInitial());

  Stream<List<Expense>> get expenses => _expensesRepository.streamExpenses();
  Future<void> addExpense({
    required double amount,
    required String category,
    // جعلنا العنوان والتاريخ اختياريين عشان يتماشوا مع التصميم السريع
    String? title,
    DateTime? date,
    String? notes,
  }) async {
    try {
      emit(ExpensesLoading());

      // 1. لو مفيش عنوان، استخدم اسم الفئة كعنوان (مثلاً: "كهرباء")
      final String finalTitle = title ?? category;

      // 2. لو مفيش تاريخ، استخدم اللحظة الحالية
      final DateTime finalDate = date ?? DateTime.now();

      await _expensesRepository.addExpense(
        title: finalTitle,
        amount: amount,
        category: category,
        date: finalDate,
        notes: notes,
      );

      emit(ExpensesSuccess());

      // Trigger Sync
      Future.delayed(const Duration(seconds: 1), () {
        getIt<SupabaseSyncService>().syncPendingData();
      });
    } catch (e) {
      emit(ExpensesError(e.toString()));
    }
  }

  Future<List<Expense>> getExpensesByDateRange(DateTime start, DateTime end) {
    return _expensesRepository.getExpensesByDateRange(start, end);
  }
}
