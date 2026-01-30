import 'package:equatable/equatable.dart';
import 'package:librarymanager/core/database/app_database.dart';

enum ManualEntryStatus { initial, loading, success, failure }

class ManualEntryState extends Equatable {
  final String? publisher;
  final String? subject;
  final String? grade;
  final String? term;
  final int quantity;
  final double costPrice;
  final double sellPrice;

  final String generatedName;
  final Book? existingBook;
  final ManualEntryStatus status;
  final String? errorMessage;

  const ManualEntryState({
    this.publisher,
    this.subject,
    this.grade,
    this.term,
    this.quantity = 0,
    this.costPrice = 0.0,
    this.sellPrice = 0.0,
    this.generatedName = '',
    this.existingBook,
    this.status = ManualEntryStatus.initial,
    this.errorMessage,
  });

  ManualEntryState copyWith({
    String? publisher,
    String? subject,
    String? grade,
    String? term,
    int? quantity,
    double? costPrice,
    double? sellPrice,
    String? generatedName,
    Book? existingBook,
    bool clearExistingBook = false,
    ManualEntryStatus? status,
    String? errorMessage,
  }) {
    return ManualEntryState(
      publisher: publisher ?? this.publisher,
      subject: subject ?? this.subject,
      grade: grade ?? this.grade,
      term: term ?? this.term,
      quantity: quantity ?? this.quantity,
      costPrice: costPrice ?? this.costPrice,
      sellPrice: sellPrice ?? this.sellPrice,
      generatedName: generatedName ?? this.generatedName,
      existingBook: clearExistingBook
          ? null
          : (existingBook ?? this.existingBook),
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    publisher,
    subject,
    grade,
    term,
    quantity,
    costPrice,
    sellPrice,
    generatedName,
    existingBook,
    status,
    errorMessage,
  ];
}
