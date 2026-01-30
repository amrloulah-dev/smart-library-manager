part of 'inventory_cubit.dart';

abstract class InventoryState {}

class InventoryInitial extends InventoryState {}

class InventoryLoading extends InventoryState {}

class InventorySuccess extends InventoryState {
  final String? message;
  InventorySuccess([this.message]);
}

class InventoryLoaded extends InventoryState {
  final List<Book> items;
  final bool hasReachedMax;
  final bool isLoadingMore;

  InventoryLoaded({
    required this.items,
    required this.hasReachedMax,
    this.isLoadingMore = false,
  });

  InventoryLoaded copyWith({
    List<Book>? items,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return InventoryLoaded(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class InventoryError extends InventoryState {
  final String message;
  InventoryError(this.message);
}
