import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drift/drift.dart' as drift;
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';

import 'package:librarymanager/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:librarymanager/features/sales/domain/repositories/sales_repository.dart';
import 'package:librarymanager/features/sales/presentation/manager/sales_state.dart';
import 'package:librarymanager/features/sales/domain/usecases/scan_book_usecase.dart';
import 'package:librarymanager/core/utils/text_normalizer.dart';
import 'package:librarymanager/app/injection.dart';
import 'package:librarymanager/core/services/supabase_sync_service.dart';

@injectable
class SalesCubit extends Cubit<SalesState> {
  final ScanBookUseCase _scanBookUseCase;
  final InventoryRepository _inventoryRepository;
  final SalesRepository _salesRepository;

  StreamSubscription? _booksSubscription;

  SalesCubit(
    this._scanBookUseCase,
    this._inventoryRepository,
    this._salesRepository,
  ) : super(const SalesState());

  @override
  Future<void> close() {
    _booksSubscription?.cancel();
    return super.close();
  }

  void loadAllBooks() {
    _booksSubscription?.cancel();
    _booksSubscription = _inventoryRepository.streamAllBooks().listen((books) {
      final filtered = _applyFilters(
        books,
        state.searchQuery,
        state.filterPublisher,
        state.filterSubject,
        state.filterGrade,
      );
      emit(state.copyWith(allBooks: books, filteredBooks: filtered));
    });
  }

  void updateCatalogFilters({
    String? searchQuery,
    String? publisher,
    String? subject,
    String? grade,
    bool clearPublisher = false,
    bool clearSubject = false,
    bool clearGrade = false,
  }) {
    final newQuery = searchQuery ?? state.searchQuery;
    final newPub = clearPublisher ? null : (publisher ?? state.filterPublisher);
    final newSub = clearSubject ? null : (subject ?? state.filterSubject);
    final newGrade = clearGrade ? null : (grade ?? state.filterGrade);

    final filtered = _applyFilters(
      state.allBooks,
      newQuery,
      newPub,
      newSub,
      newGrade,
    );

    // We must manually construct state to allow setting nulls (since copyWith ?? doesn't allow it easily)
    emit(
      SalesState(
        cartItems: state.cartItems,
        status: state.status,
        totalAmount: state.totalAmount,
        errorMessage: state.errorMessage,
        discountAmount: state.discountAmount,
        zeroStockBook: state.zeroStockBook,
        selectedCustomer: state.selectedCustomer,
        allBooks: state.allBooks,
        filteredBooks: filtered,
        searchQuery: newQuery,
        filterPublisher: newPub,
        filterSubject: newSub,
        filterGrade: newGrade,
      ),
    );
  }

  List<Book> _applyFilters(
    List<Book> books,
    String query,
    String? pub,
    String? sub,
    String? grade,
  ) {
    // Normalize filter inputs once
    final normPub = pub != null
        ? TextNormalizer.standardizeBookName(pub)
        : null;
    final normSub = sub != null
        ? TextNormalizer.standardizeBookName(sub)
        : null;
    final normGrade = grade != null
        ? TextNormalizer.standardizeBookName(grade)
        : null;

    return books.where((b) {
      // Normalize book name as primary search target
      final bookNameNorm = TextNormalizer.standardizeBookName(b.name);

      // Publisher Filter
      if (normPub != null) {
        if (!bookNameNorm.contains(normPub)) return false;
      }

      // Subject Filter
      if (normSub != null) {
        if (!bookNameNorm.contains(normSub)) return false;
      }

      // Grade Filter
      if (normGrade != null) {
        if (!bookNameNorm.contains(normGrade)) return false;
      }

      // Search Query Logic
      if (query.isNotEmpty) {
        final qLower = query.toLowerCase();
        final matchName = b.name.toLowerCase().contains(qLower);
        final matchPub = b.publisher?.toLowerCase().contains(qLower) ?? false;
        final matchKey =
            b.searchKeywords?.toLowerCase().contains(qLower) ?? false;
        if (!matchName && !matchPub && !matchKey) return false;
      }
      return true;
    }).toList();
  }

  String? _linkedReservationId;
  void setLinkedReservationId(String? id) {
    _linkedReservationId = id;
  }

  Future<void> scanBook(File image) async {
    emit(state.copyWith(status: SalesStatus.scanning));

    final result = await _scanBookUseCase.execute(image);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: SalesStatus.bookNotFound,
            errorMessage: failure.message,
          ),
        );
      },
      (book) {
        // Check stock before adding to cart
        final success = addToCart(book);
        if (!success) {
          emit(
            state.copyWith(status: SalesStatus.stockZero, zeroStockBook: book),
          );
          return;
        }
        emit(state.copyWith(status: SalesStatus.initial));
      },
    );
  }

  bool addToCart(Book book) {
    // Check if book already in cart
    final index = state.cartItems.indexWhere((item) => item.bookId == book.id);
    List<PosCartItem> newItems = List.from(state.cartItems);

    if (index >= 0) {
      final current = newItems[index];
      // Validation Logic: check against book.currentStock
      if (current.quantity + 1 > book.currentStock) {
        return false;
      }
      newItems[index] = current.copyWith(quantity: current.quantity + 1);
    } else {
      // First time adding - also check if stock is at least 1
      if (book.currentStock < 1) {
        return false;
      }
      newItems.add(
        PosCartItem(
          book: book,
          title: book.name,
          quantity: 1,
          price: book.sellPrice,
          bookId: book.id,
        ),
      );
    }
    _emitCart(newItems);
    return true;
  }

  Future<void> fetchAndAddBook(String bookId) async {
    try {
      final book = await _inventoryRepository.getBookById(bookId);
      if (book != null) {
        final success = addToCart(book);
        if (!success) {
          emit(
            state.copyWith(status: SalesStatus.stockZero, zeroStockBook: book),
          );
          return;
        }
      }
    } catch (e) {
      emit(
        state.copyWith(status: SalesStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void addManualItem(
    String name,
    double price, {
    int quantity = 1,
    double? cost,
  }) {
    // Fallback Logic: If cost is not provided or is 0, assume 20% profit margin
    double finalCost = cost ?? 0.0;
    if (finalCost == 0.0 && price > 0) {
      finalCost = price * 0.8; // Assume 20% margin if cost is unknown
    }

    List<PosCartItem> newItems = List.from(state.cartItems);
    newItems.add(
      PosCartItem(
        title: name,
        price: price,
        quantity: quantity,
        book: null,
        bookId: null,
        costPrice: finalCost,
      ),
    );
    _emitCart(
      newItems,
      status: SalesStatus.initial,
    ); // Reset status if it was bookNotFound
  }

  void removeFromCart(int index) {
    if (index < 0 || index >= state.cartItems.length) return;
    List<PosCartItem> newItems = List.from(state.cartItems);
    newItems.removeAt(index);
    _emitCart(newItems);
  }

  void updateQuantity(int index, int change) {
    if (index < 0 || index >= state.cartItems.length) return;
    List<PosCartItem> newItems = List.from(state.cartItems);
    final current = newItems[index];
    final newQty = current.quantity + change;
    if (newQty <= 0) {
      newItems.removeAt(index);
    } else {
      newItems[index] = current.copyWith(quantity: newQty);
    }
    _emitCart(newItems);
  }

  double _calculateNetTotal(double subtotal, double discountPercentage) {
    if (subtotal <= 0) return 0.0;
    // Formula: (Sum of Item Prices) - ((Sum of Item Prices) * (discountPercentage / 100))
    return subtotal - (subtotal * (discountPercentage / 100));
  }

  void _emitCart(List<PosCartItem> items, {SalesStatus? status}) {
    // 1. Calculate Subtotal (Sum of Item Prices)
    final subtotal = items.fold(0.0, (sum, item) {
      final price = item.book?.sellPrice ?? item.price;
      return sum + (price * item.quantity);
    });

    // 2. Calculate Discount Amount
    double discountVal = state.discountAmount;
    if (state.discountPercentage > 0) {
      discountVal = subtotal * (state.discountPercentage / 100);
    }

    // 3. Calculate Net Total using centralized logic if percentage is active
    // If percentage is active, ensure we use the formula strictly
    double netTotal;
    if (state.discountPercentage > 0) {
      netTotal = _calculateNetTotal(subtotal, state.discountPercentage);
    } else {
      netTotal = subtotal - discountVal;
    }

    emit(
      state.copyWith(
        cartItems: items,
        totalAmount: netTotal > 0 ? netTotal : 0,
        discountAmount: discountVal,
        status: status ?? state.status,
      ),
    );
  }

  void applyGlobalDiscount(double percentage) {
    final subtotal = state.cartItems.fold(0.0, (sum, item) {
      final price = item.book?.sellPrice ?? item.price;
      return sum + (price * item.quantity);
    });

    final discountAmount = subtotal * (percentage / 100);
    final netTotal = _calculateNetTotal(subtotal, percentage);

    emit(
      state.copyWith(
        discountPercentage: percentage,
        discountAmount: discountAmount,
        totalAmount: netTotal > 0 ? netTotal : 0,
      ),
    );
  }

  void applyFixedAmountDiscount(double amount) {
    final subtotal = state.cartItems.fold(0.0, (sum, item) {
      final price = item.book?.sellPrice ?? item.price;
      return sum + (price * item.quantity);
    });
    final total = subtotal - amount;

    emit(
      state.copyWith(
        discountPercentage: 0.0, // Reset percentage
        discountAmount: amount,
        totalAmount: total > 0 ? total : 0,
      ),
    );
  }

  void clearDiscount() {
    final subtotal = state.cartItems.fold(0.0, (sum, item) {
      final price = item.book?.sellPrice ?? item.price;
      return sum + (price * item.quantity);
    });
    emit(
      state.copyWith(
        discountPercentage: 0.0,
        discountAmount: 0.0,
        totalAmount: subtotal,
      ),
    );
  }

  /// Clear all items from the cart and reset totals
  void clearCart() {
    emit(state.copyWith(cartItems: [], totalAmount: 0.0, discountAmount: 0.0));
  }

  Future<void> checkout({
    required String paymentType,
    // Discount is already applied in state.totalAmount
    // We capture it from state to log it, but don't subtract it again.
    double? discountOverride,
    String? linkedReservationId,
  }) async {
    if (state.cartItems.isEmpty) return;

    emit(state.copyWith(status: SalesStatus.scanning));

    try {
      final finalTotal = state.totalAmount; // This is the Net Total
      final discountUsed = discountOverride ?? state.discountAmount;

      // Prepare Sale Object
      final customerId = state.selectedCustomer?.id;
      final sale = SalesCompanion(
        customerId: customerId == null
            ? const drift.Value.absent()
            : drift.Value(customerId),
        saleDate: drift.Value(DateTime.now()),
        paymentType: drift.Value(paymentType),
        // Storing Net Total as totalAmount to match user expectation of "Total"
        // Or should totalAmount be Gross?
        // Usually schema: Total = Gross, Paid = Net.
        // But for this fix, we ensure consistency.
        // If we store Net in totalAmount, we should be consistent.
        // Let's assume totalAmount in DB is Gross for reporting context usually, but if I change it now it might break reports.
        // However, the user wants UI fixed. I will use state.totalAmount as the amount to PAY.
        // For DB, I will reconstruct Gross if needed or just save Net.
        // Let's safe-guard:
        // Gross = Final + Discount.
        totalAmount: drift.Value(finalTotal + discountUsed),
        discountValue: drift.Value(discountUsed),
        paidAmount: drift.Value(paymentType == 'Credit' ? 0.0 : finalTotal),
        remainingAmount: drift.Value(
          paymentType == 'Credit' ? finalTotal : 0.0,
        ),
        totalProfit: const drift.Value(0),
      );

      // Prepare Items
      // We need to fetch Cost for profit calculation.
      // But map items first.
      List<SaleItemsCompanion> saleItems = [];
      double absoluteTotalCost = 0;

      for (var item in state.cartItems) {
        // For tracked books, use book.costPrice
        // For manual items, use item.costPrice (which has fallback logic applied)
        double unitCost = 0.0;
        if (item.book != null) {
          unitCost = item.book!.costPrice;
        } else {
          // Manual item - use the stored costPrice (with 80% fallback already applied)
          unitCost = item.costPrice;
        }

        absoluteTotalCost += (unitCost * item.quantity);

        saleItems.add(
          SaleItemsCompanion(
            bookId: item.bookId == null
                ? const drift.Value.absent()
                : drift.Value(item.bookId!),
            quantity: drift.Value(item.quantity),
            unitPrice: drift.Value(item.price),
            unitCostAtSale: drift.Value(unitCost),
            // saleId linked in repository
          ),
        );
      }

      final profit =
          finalTotal -
          absoluteTotalCost; // Approx profit accounting for discount.
      // If discount applied, it eats into profit.

      final saleWithProfit = sale.copyWith(totalProfit: drift.Value(profit));

      await _salesRepository.processSaleTransaction(
        sale: saleWithProfit,
        items: saleItems,
        customerId: customerId,
        linkedReservationId: linkedReservationId ?? _linkedReservationId,
      );

      // Reset linked ID after successful checkout
      _linkedReservationId = null;

      emit(
        state.copyWith(
          status: SalesStatus.success,
          cartItems: [],
          totalAmount: 0,
          selectedCustomer: null,
          discountAmount: 0,
        ),
      );

      // Trigger Offline Sync
      Future.delayed(const Duration(seconds: 1), () {
        getIt<SupabaseSyncService>().syncPendingData();
      });
    } catch (e) {
      emit(
        state.copyWith(status: SalesStatus.error, errorMessage: e.toString()),
      );
    }
  }

  // Customer Management
  Future<void> addCustomer(String name, String phone) async {
    try {
      final companion = CustomersCompanion(
        name: drift.Value(name),
        phone: drift.Value(phone),
        lastUpdated: drift.Value(DateTime.now()),
      );
      final newCustomer = await _inventoryRepository.createCustomer(companion);

      // Auto-select
      emit(state.copyWith(selectedCustomer: newCustomer));

      // Trigger Offline Sync
      Future.delayed(const Duration(seconds: 1), () {
        getIt<SupabaseSyncService>().syncPendingData();
      });
    } catch (e) {
      emit(
        state.copyWith(status: SalesStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<List<Customer>> searchCustomers(String query) {
    return _inventoryRepository.searchCustomers(query);
  }

  void selectCustomer(Customer? customer) {
    emit(state.copyWith(selectedCustomer: customer));
  }

  /// Process customer return - uses the already-found Book object directly
  /// NO database re-query - the book was already found in BookAttributeSelectorSheet
  Future<void> processCustomerReturnWithBook(
    Book book, {
    double discountPercentage = 0,
  }) async {
    emit(state.copyWith(status: SalesStatus.scanning)); // Use as loading state

    try {
      final refundAmount = book.sellPrice * (1 - discountPercentage / 100);

      // Process return through SalesRepository - uses the stored Book directly
      await _salesRepository.processExchange(
        returnedItems: [book],
        newItems: [], // No exchange, just return
        finalReturnItemRefund: refundAmount,
      );

      emit(state.copyWith(status: SalesStatus.success, errorMessage: null));

      // Trigger Offline Sync
      Future.delayed(const Duration(seconds: 1), () {
        getIt<SupabaseSyncService>().syncPendingData();
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        emit(state.copyWith(status: SalesStatus.initial));
      });
    } catch (e) {
      emit(
        state.copyWith(
          status: SalesStatus.error,
          errorMessage: 'فشل في معالجة الإرجاع: ${e.toString()}',
        ),
      );
    }
  }

  /// Process book exchange - swap returned book for new book with discounts
  Future<void> processBookExchange({
    required Book returnedBook,
    required double returnDiscountPercent,
    required Book newBook,
    required double newDiscountPercent,
  }) async {
    emit(state.copyWith(status: SalesStatus.scanning)); // Load state

    try {
      // Calculate prices after discount
      final returnPrice =
          returnedBook.sellPrice * (1 - returnDiscountPercent / 100);
      final newPrice = newBook.sellPrice * (1 - newDiscountPercent / 100);

      // Process exchange through SalesRepository with calculated discounted prices
      await _salesRepository.processExchange(
        returnedItems: [returnedBook],
        newItems: [newBook],
        finalNewItemPrice: newPrice,
        finalReturnItemRefund: returnPrice,
      );

      // Success
      emit(state.copyWith(status: SalesStatus.success, errorMessage: null));

      // Trigger Offline Sync
      Future.delayed(const Duration(seconds: 1), () {
        getIt<SupabaseSyncService>().syncPendingData();
      });

      // Reset to initial after short delay
      Future.delayed(const Duration(milliseconds: 500), () {
        emit(state.copyWith(status: SalesStatus.initial));
      });
    } catch (e) {
      emit(
        state.copyWith(
          status: SalesStatus.error,
          errorMessage: 'فشل في معالجة الاستبدال: ${e.toString()}',
        ),
      );
    }
  }
}
