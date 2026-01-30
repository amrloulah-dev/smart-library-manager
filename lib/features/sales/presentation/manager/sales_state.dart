import 'package:equatable/equatable.dart';
import 'package:librarymanager/core/database/app_database.dart';

enum SalesStatus { initial, scanning, success, error, bookNotFound, stockZero }

class PosCartItem extends Equatable {
  final Book?
  book; // Null if manual item? Req says "Unknown Item... popup... add as temporary item".
  // If temporary item, book might be null or a "dummy" book.
  // Best to have explicit fields for display if book is null.
  final String title;
  final int quantity;
  final double price;
  final String? bookId; // Null if temporary/manual
  final double
  costPrice; // Cost price for profit calculation (especially for manual items)

  const PosCartItem({
    this.book,
    required this.title,
    required this.quantity,
    required this.price,
    this.bookId,
    this.costPrice = 0.0,
  });

  PosCartItem copyWith({
    Book? book,
    String? title,
    int? quantity,
    double? price,
    String? bookId,
    double? costPrice,
  }) {
    return PosCartItem(
      book: book ?? this.book,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      bookId: bookId ?? this.bookId,
      costPrice: costPrice ?? this.costPrice,
    );
  }

  double get total => price * quantity;

  @override
  List<Object?> get props => [book, title, quantity, price, bookId, costPrice];
}

class SalesState extends Equatable {
  final List<PosCartItem> cartItems;
  final SalesStatus status;
  final double totalAmount;
  final String? errorMessage;
  final double discountAmount;
  final double discountPercentage;
  final Book? zeroStockBook; // Book that triggered stockZero status
  final Customer? selectedCustomer; // Selected customer for the sale

  // Catalogue State
  final List<Book> allBooks;
  final List<Book> filteredBooks;
  final String searchQuery;
  final String? filterPublisher;
  final String? filterSubject;
  final String? filterGrade;

  const SalesState({
    this.cartItems = const [],
    this.status = SalesStatus.initial,
    this.totalAmount = 0.0,
    this.errorMessage,
    this.discountAmount = 0.0,
    this.discountPercentage = 0.0,
    this.zeroStockBook,
    this.selectedCustomer,
    this.allBooks = const [],
    this.filteredBooks = const [],
    this.searchQuery = '',
    this.filterPublisher,
    this.filterSubject,
    this.filterGrade,
  });

  SalesState copyWith({
    List<PosCartItem>? cartItems,
    SalesStatus? status,
    double? totalAmount,
    String? errorMessage,
    double? discountAmount,
    double? discountPercentage,
    Book? zeroStockBook,
    Customer? selectedCustomer,
    List<Book>? allBooks,
    List<Book>? filteredBooks,
    String? searchQuery,
    String? filterPublisher,
    String? filterSubject,
    String? filterGrade,
  }) {
    return SalesState(
      cartItems: cartItems ?? this.cartItems,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      errorMessage: errorMessage ?? this.errorMessage,
      discountAmount: discountAmount ?? this.discountAmount,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      zeroStockBook: zeroStockBook ?? this.zeroStockBook,
      selectedCustomer: selectedCustomer ?? this.selectedCustomer,
      allBooks: allBooks ?? this.allBooks,
      filteredBooks: filteredBooks ?? this.filteredBooks,
      searchQuery: searchQuery ?? this.searchQuery,
      filterPublisher: filterPublisher ?? this.filterPublisher,
      filterSubject: filterSubject ?? this.filterSubject,
      filterGrade: filterGrade ?? this.filterGrade,
    );
  }

  @override
  List<Object?> get props => [
    cartItems,
    status,
    totalAmount,
    errorMessage,
    discountAmount,
    discountPercentage,
    zeroStockBook,
    selectedCustomer,
    allBooks,
    filteredBooks,
    searchQuery,
    filterPublisher,
    filterSubject,
    filterGrade,
  ];
}
