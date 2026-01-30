import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/inventory/presentation/manager/manual_invoice_state.dart';

class ReturnsFormState extends Equatable {
  final Supplier? selectedSupplier;
  final List<ManualInvoiceItem> items;
  final double discountPercentage;

  const ReturnsFormState({
    this.selectedSupplier,
    this.items = const [],
    this.discountPercentage = 0.0,
  });

  ReturnsFormState copyWith({
    Supplier? selectedSupplier,
    List<ManualInvoiceItem>? items,
    double? discountPercentage,
  }) {
    return ReturnsFormState(
      selectedSupplier: selectedSupplier ?? this.selectedSupplier,
      items: items ?? this.items,
      discountPercentage: discountPercentage ?? this.discountPercentage,
    );
  }

  @override
  List<Object?> get props => [selectedSupplier, items, discountPercentage];
}

@injectable
class ReturnsFormCubit extends Cubit<ReturnsFormState> {
  ReturnsFormCubit() : super(const ReturnsFormState());

  void selectSupplier(Supplier? supplier) {
    emit(state.copyWith(selectedSupplier: supplier));
  }

  void addItem(ManualInvoiceItem item) {
    final updatedItems = List<ManualInvoiceItem>.from(state.items)..add(item);
    emit(state.copyWith(items: updatedItems));
  }

  void removeItem(int index) {
    final updatedItems = List<ManualInvoiceItem>.from(state.items)
      ..removeAt(index);
    emit(state.copyWith(items: updatedItems));
  }

  void updateDiscount(double discount) {
    emit(state.copyWith(discountPercentage: discount));
  }

  void reset() {
    emit(const ReturnsFormState());
  }
}
