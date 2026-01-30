part of 'supplier_return_cubit.dart';

abstract class SupplierReturnState extends Equatable {
  const SupplierReturnState();
  @override
  List<Object> get props => [];
}

class SupplierReturnInitial extends SupplierReturnState {}

class SupplierReturnLoading extends SupplierReturnState {}

class SupplierReturnLoaded extends SupplierReturnState {
  final List<Book> books;
  // We might naturally need to hold selection state here if we want to survive rebuilds,
  // but keeping it local to UI is simpler for "Selection" unless we want complex logic.
  // Requirement says "Loaded (List of Books)".
  const SupplierReturnLoaded(this.books);

  @override
  List<Object> get props => [books];
}

class SupplierReturnSuccess extends SupplierReturnState {
  final String message;
  const SupplierReturnSuccess(this.message);
}

class SupplierReturnError extends SupplierReturnState {
  final String message;
  const SupplierReturnError(this.message);
}
