import 'package:equatable/equatable.dart';

class ExpenseFormState extends Equatable {
  final int selectedCategoryIndex;

  const ExpenseFormState({this.selectedCategoryIndex = 0});

  ExpenseFormState copyWith({int? selectedCategoryIndex}) {
    return ExpenseFormState(
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
    );
  }

  @override
  List<Object> get props => [selectedCategoryIndex];
}
