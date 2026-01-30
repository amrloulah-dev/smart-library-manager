import 'package:equatable/equatable.dart';
import 'package:librarymanager/core/database/app_database.dart';

class ReservationFormState extends Equatable {
  final List<Book> searchResults;
  final bool isSearching;
  final Book? selectedBook;
  final String customerName;
  final String phone;
  final double deposit;

  const ReservationFormState({
    this.searchResults = const [],
    this.isSearching = false,
    this.selectedBook,
    this.customerName = '',
    this.phone = '',
    this.deposit = 0.0,
  });

  ReservationFormState copyWith({
    List<Book>? searchResults,
    bool? isSearching,
    Book? selectedBook,
    String? customerName,
    String? phone,
    double? deposit,
  }) {
    return ReservationFormState(
      searchResults: searchResults ?? this.searchResults,
      isSearching: isSearching ?? this.isSearching,
      selectedBook: selectedBook ?? this.selectedBook,
      customerName: customerName ?? this.customerName,
      phone: phone ?? this.phone,
      deposit: deposit ?? this.deposit,
    );
  }

  @override
  List<Object?> get props => [
    searchResults,
    isSearching,
    selectedBook,
    customerName,
    phone,
    deposit,
  ];
}
