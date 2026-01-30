part of 'supplier_details_cubit.dart';

abstract class SupplierDetailsState extends Equatable {
  const SupplierDetailsState();

  @override
  List<Object> get props => [];
}

class SupplierDetailsInitial extends SupplierDetailsState {}

class SupplierDetailsLoading extends SupplierDetailsState {}

class SupplierDetailsLoaded extends SupplierDetailsState {
  final SupplierStats stats;

  const SupplierDetailsLoaded(this.stats);

  @override
  List<Object> get props => [stats];
}

class SupplierDetailsError extends SupplierDetailsState {
  final String message;

  const SupplierDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
