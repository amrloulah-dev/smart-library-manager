part of 'exchange_cubit.dart';

enum ExchangeStatus { initial, loading, success, error }

class ExchangeState extends Equatable {
  final List<Book> returnedItems;
  final List<Book> newItems;
  final ExchangeStatus status;
  final String? errorMessage;

  const ExchangeState({
    this.returnedItems = const [],
    this.newItems = const [],
    this.status = ExchangeStatus.initial,
    this.errorMessage,
  });

  double get totalReturned =>
      returnedItems.fold(0.0, (sum, item) => sum + item.sellPrice);

  double get totalNew =>
      newItems.fold(0.0, (sum, item) => sum + item.sellPrice);

  double get netDifference => totalNew - totalReturned;

  ExchangeState copyWith({
    List<Book>? returnedItems,
    List<Book>? newItems,
    ExchangeStatus? status,
    String? errorMessage,
  }) {
    return ExchangeState(
      returnedItems: returnedItems ?? this.returnedItems,
      newItems: newItems ?? this.newItems,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [returnedItems, newItems, status, errorMessage];
}
