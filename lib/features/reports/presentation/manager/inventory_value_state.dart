import 'package:equatable/equatable.dart';

abstract class InventoryValueState extends Equatable {
  const InventoryValueState();

  @override
  List<Object> get props => [];
}

class InventoryValueInitial extends InventoryValueState {}

class InventoryValueLoading extends InventoryValueState {}

class InventoryValueLoaded extends InventoryValueState {
  final double value;

  const InventoryValueLoaded(this.value);

  @override
  List<Object> get props => [value];
}

class InventoryValueError extends InventoryValueState {
  final String message;

  const InventoryValueError(this.message);

  @override
  List<Object> get props => [message];
}
