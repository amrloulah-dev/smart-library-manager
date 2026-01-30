part of 'invoice_details_cubit.dart';

abstract class InvoiceDetailsState extends Equatable {
  const InvoiceDetailsState();

  @override
  List<Object> get props => [];
}

class InvoiceDetailsInitial extends InvoiceDetailsState {}

class InvoiceDetailsLoading extends InvoiceDetailsState {}

class InvoiceDetailsLoaded extends InvoiceDetailsState {
  final InvoiceDetailModel details;

  const InvoiceDetailsLoaded(this.details);

  @override
  List<Object> get props => [details];
}

class InvoiceDetailsError extends InvoiceDetailsState {
  final String message;

  const InvoiceDetailsError(this.message);

  @override
  List<Object> get props => [message];
}

class InvoiceDeletedSuccess extends InvoiceDetailsState {}
