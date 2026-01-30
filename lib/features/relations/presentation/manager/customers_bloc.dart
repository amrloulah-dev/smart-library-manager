import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import '../../../sales/domain/repositories/customers_repository.dart';

// Events
abstract class CustomersEvent extends Equatable {
  const CustomersEvent();
  @override
  List<Object> get props => [];
}

class AddCustomerRequested extends CustomersEvent {
  final String name;
  final String phone;

  const AddCustomerRequested(this.name, this.phone);

  @override
  List<Object> get props => [name, phone];
}

class DeleteCustomerEvent extends CustomersEvent {
  final String customerId;

  const DeleteCustomerEvent(this.customerId);

  @override
  List<Object> get props => [customerId];
}

// States
abstract class CustomersState extends Equatable {
  const CustomersState();
  @override
  List<Object> get props => [];
}

class CustomersInitial extends CustomersState {}

class CustomersLoading extends CustomersState {}

class CustomersSuccess extends CustomersState {
  final String message;
  final Customer customer;
  const CustomersSuccess(this.message, this.customer);
  @override
  List<Object> get props => [message, customer];
}

class CustomersError extends CustomersState {
  final String message;
  const CustomersError(this.message);
  @override
  List<Object> get props => [message];
}

// Bloc implementation
@injectable
class CustomersBloc extends Bloc<CustomersEvent, CustomersState> {
  final CustomersRepository _customersRepository;

  CustomersBloc(this._customersRepository) : super(CustomersInitial()) {
    on<AddCustomerRequested>(_onAddCustomer);
    on<DeleteCustomerEvent>(_onDeleteCustomer);
  }

  Future<void> _onAddCustomer(
    AddCustomerRequested event,
    Emitter<CustomersState> emit,
  ) async {
    emit(CustomersLoading());
    try {
      final customer = await _customersRepository.addCustomer(
        event.name,
        event.phone,
      );
      emit(CustomersSuccess('تم إضافة العميل بنجاح', customer));
    } catch (e) {
      emit(CustomersError('فشل إضافة العميل: $e'));
    }
  }

  Future<void> _onDeleteCustomer(
    DeleteCustomerEvent event,
    Emitter<CustomersState> emit,
  ) async {
    // Note: We don't emit loading here to avoid full screen loader flicker if list is streaming.
    // If we wanted to show feedback, we might use a separate action state or rely on stream update.
    try {
      await _customersRepository.deleteClient(event.customerId);
      // Success message could be emitted if we weren't streaming.
      // Since UI is likely a StreamBuilder on repository, it will auto-update.
      // But if we want to show a snackbar, we can emit a side-effect state or just rely on UI action completion.
    } catch (e) {
      emit(CustomersError('فشل حذف العميل: $e'));
    }
  }
}
