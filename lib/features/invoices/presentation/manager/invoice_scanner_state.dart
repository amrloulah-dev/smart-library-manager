part of 'invoice_scanner_cubit.dart';

enum InvoiceScannerStatus { initial, scanning, reviewing, success, error }

class InvoiceScannerState extends Equatable {
  final InvoiceScannerStatus status;
  final Supplier? selectedSupplier;
  final DateTime invoiceDate;
  final List<ScannedItemModel> scannedItems;
  final String? errorMessage;
  final String? successMessage;

  const InvoiceScannerState({
    this.status = InvoiceScannerStatus.initial,
    this.selectedSupplier,
    required this.invoiceDate,
    this.scannedItems = const [],
    this.errorMessage,
    this.successMessage,
  });

  InvoiceScannerState.initial()
    : status = InvoiceScannerStatus.initial,
      selectedSupplier = null,
      invoiceDate = DateTime.fromMicrosecondsSinceEpoch(0),
      scannedItems = const [],
      errorMessage = null,
      successMessage = null;

  InvoiceScannerState copyWith({
    InvoiceScannerStatus? status,
    Supplier? selectedSupplier,
    DateTime? invoiceDate,
    List<ScannedItemModel>? scannedItems,
    String? errorMessage,
    String? successMessage,
  }) {
    return InvoiceScannerState(
      status: status ?? this.status,
      selectedSupplier: selectedSupplier ?? this.selectedSupplier,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      scannedItems: scannedItems ?? this.scannedItems,
      // Note: errorMessage and successMessage are NOT persisted by default.
      // They are transient. To keep them, you must re-pass them, which is rare.
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedSupplier,
    invoiceDate,
    scannedItems,
    errorMessage,
    successMessage,
  ];
}
