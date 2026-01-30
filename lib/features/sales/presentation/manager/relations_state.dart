part of 'relations_cubit.dart';

abstract class RelationsState extends Equatable {
  const RelationsState();

  @override
  List<Object> get props => [];
}

class RelationsInitial extends RelationsState {}

class RelationsTabChanged extends RelationsState {
  final int index;
  const RelationsTabChanged(this.index);

  @override
  List<Object> get props => [index];
}
