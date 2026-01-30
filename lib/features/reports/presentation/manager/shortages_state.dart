part of 'shortages_cubit.dart';

abstract class ShortagesState extends Equatable {
  const ShortagesState();

  @override
  List<Object> get props => [];
}

class ShortagesInitial extends ShortagesState {}

class ShortagesLoading extends ShortagesState {}

class ShortagesLoaded extends ShortagesState {
  final List<ShortageItem> items;

  const ShortagesLoaded({required this.items});

  @override
  List<Object> get props => [items];
}

class ShortagesError extends ShortagesState {
  final String message;

  const ShortagesError(this.message);

  @override
  List<Object> get props => [message];
}

enum ShortageType { reservation, outOfStock, smartRestock }

class ShortageItem extends Equatable {
  final ShortageType type;
  final Book? book; // Nullable only if book data is missing for a reservation
  final Reservation? reservation;
  final int quantity;
  final String reason;
  final double confidence;

  const ShortageItem({
    required this.type,
    this.book,
    this.reservation,
    required this.quantity,
    required this.reason,
    this.confidence = 1.0,
  });

  @override
  List<Object?> get props => [
    type,
    book,
    reservation,
    quantity,
    reason,
    confidence,
  ];
}
