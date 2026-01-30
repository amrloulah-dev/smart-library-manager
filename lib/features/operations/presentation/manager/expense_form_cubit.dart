import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'expense_form_state.dart';

@injectable
class ExpenseFormCubit extends Cubit<ExpenseFormState> {
  ExpenseFormCubit() : super(const ExpenseFormState());

  void selectCategory(int index) {
    emit(state.copyWith(selectedCategoryIndex: index));
  }
}
