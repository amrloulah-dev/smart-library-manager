import 'package:equatable/equatable.dart';
import 'package:librarymanager/core/database/app_database.dart'; // For Book class

class SalesSearchState extends Equatable {
  final bool isLoading;
  final List<Book> results;
  final String query;
  final String? selectedPublisher;
  final String? selectedSubject;
  final String? selectedGrade;
  final String? selectedTerm;

  const SalesSearchState({
    this.isLoading = false,
    this.results = const [],
    this.query = '',
    this.selectedPublisher,
    this.selectedSubject,
    this.selectedGrade,
    this.selectedTerm,
  });

  SalesSearchState copyWith({
    bool? isLoading,
    List<Book>? results,
    String? query,
    String? selectedPublisher,
    String? selectedSubject,
    String? selectedGrade,
    String? selectedTerm,
    // Special flag to clear filters if needed, or nulls in copyWith overwrite?
    // Usually nulls in copyWith are ignored. To clear, we might need specific cleared object or explicit null handling.
    // simpler: allow nulls. if I pass null, does it mean ignore or set to null?
    // Standard copyWith: if (x != null) x else this.x.
    // To set to null, we need "Value class" or sentinel.
    // For simplicity, I will assume if I want to clear, I pass explicit null and handle logic carefully,
    // OR I add specific clear methods in Cubit that emit new state with nulls.
    bool clearPublisher = false,
    bool clearSubject = false,
    bool clearGrade = false,
    bool clearTerm = false,
  }) {
    return SalesSearchState(
      isLoading: isLoading ?? this.isLoading,
      results: results ?? this.results,
      query: query ?? this.query,
      selectedPublisher: clearPublisher
          ? null
          : (selectedPublisher ?? this.selectedPublisher),
      selectedSubject: clearSubject
          ? null
          : (selectedSubject ?? this.selectedSubject),
      selectedGrade: clearGrade ? null : (selectedGrade ?? this.selectedGrade),
      selectedTerm: clearTerm ? null : (selectedTerm ?? this.selectedTerm),
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    results,
    query,
    selectedPublisher,
    selectedSubject,
    selectedGrade,
    selectedTerm,
  ];
}
