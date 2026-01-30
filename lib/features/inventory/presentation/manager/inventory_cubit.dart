import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:librarymanager/features/inventory/domain/models/inventory_filter.dart';
import 'package:librarymanager/features/reports/domain/services/business_intelligence_service.dart';
import 'package:librarymanager/app/injection.dart';
import 'package:librarymanager/core/services/supabase_sync_service.dart';

part 'inventory_state.dart';

@lazySingleton
class InventoryCubit extends Cubit<InventoryState> {
  final InventoryRepository _repository;
  final BusinessIntelligenceService _biService;

  InventoryCubit(this._repository, this._biService)
    : super(InventoryInitial()) {
    _init();
  }

  Future<void> _init() async {
    // Self-Healing Phase: Fix any corrupted data before display
    await _repository.repairBooks();
    // Then load the inventory
    loadBooks(isRefresh: true);
  }

  void loadInventoryItems() {
    loadBooks(isRefresh: true);
  }

  // State Variables
  String _searchQuery = '';
  InventoryFilter _selectedFilter = InventoryFilter.all;

  // Pagination State
  List<Book> _allBooks = [];
  int _currentPage = 0;
  static const int _pageSize = 20;
  bool _hasReachedMax = false;

  InventoryFilter get selectedFilter => _selectedFilter;
  String get searchQuery => _searchQuery;

  // Stream for Suppliers
  Stream<List<Supplier>> get suppliersStream =>
      _repository.streamAllSuppliers();

  // Stream for Books (used by ManualEntrySheet in Return Mode)
  Stream<List<Book>> get booksStream => _repository.streamAllBooks();

  StreamSubscription? _booksSubscription;

  @override
  Future<void> close() {
    _booksSubscription?.cancel();
    return super.close();
  }

  bool _isLoadingMore = false;

  Future<void> loadBooks({bool isRefresh = false}) async {
    // 1. Guard against duplicate calls ONLY if we are paging (not refreshing)
    if (!isRefresh && _isLoadingMore) {
      return;
    }

    if (isRefresh) {
      _currentPage = 0;
      _hasReachedMax = false;
      _allBooks.clear();
      // Only emit main loading if refreshing (full screen loader)
      emit(InventoryLoading());
    } else {
      // If not refreshing and reached max, stop.
      if (_hasReachedMax) {
        return;
      }

      // Set loading more state
      _isLoadingMore = true;
      if (state is InventoryLoaded) {
        emit((state as InventoryLoaded).copyWith(isLoadingMore: true));
      }
    }

    // Special handling for Low Stock (Shortages) using AI Logic
    // This overrides the standard pagination to ensure we see ALL AI-flagged shortages.
    if (_selectedFilter == InventoryFilter.lowStock) {
      _booksSubscription?.cancel();
      _booksSubscription = _repository
          .streamAllBooks()
          .map((books) {
            // Filter in Dart using the Smart Algorithm
            return books.where((b) => _biService.isShortage(b)).toList();
          })
          .listen(
            (books) {
              if (!isClosed) {
                _allBooks = books;
                _hasReachedMax = true; // Loaded all relevant items at once
                emit(
                  InventoryLoaded(
                    items: List.from(_allBooks),
                    hasReachedMax: true,
                    isLoadingMore: false,
                  ),
                );
              }
            },
            onError: (e) {
              if (!isClosed) {
                emit(InventoryError('Failed to load shortages: $e'));
              }
            },
          );
      return;
    }

    // Standard Future-based Pagination
    try {
      final int offset = _currentPage * _pageSize;

      final books = await _repository.getBooksPaginated(
        limit: _pageSize,
        offset: offset,
        searchQuery: _searchQuery,
        filter: _selectedFilter,
      );

      if (books.length < _pageSize) {
        _hasReachedMax = true;
      } else {
        _hasReachedMax = false;
      }

      if (isRefresh) {
        _allBooks = books;
      } else {
        _allBooks.addAll(books);
      }

      emit(
        InventoryLoaded(
          items: List.from(_allBooks),
          hasReachedMax: _hasReachedMax,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(InventoryError('Failed to load books: $e'));
    } finally {
      if (!isRefresh) {
        _isLoadingMore = false;
      }
    }
  }

  void loadMoreBooks() {
    if (state is! InventoryLoaded) return;

    // Just trigger main logic
    _currentPage++;
    loadBooks(isRefresh: false);
  }

  void updateSearch(String query) {
    if (_searchQuery == query) return;
    _searchQuery = query;
    loadBooks(isRefresh: true);
  }

  void updateFilter(InventoryFilter filter) {
    if (_selectedFilter == filter) return;
    _selectedFilter = filter;
    loadBooks(isRefresh: true);
  }

  Future<void> addSupplier(String name, String phone) async {
    try {
      await _repository.insertSupplier(
        SuppliersCompanion(
          name: Value(name),
          phone: Value(phone),
          balance: const Value(0.0),
          lastUpdated: Value(DateTime.now()),
        ),
      );

      // Trigger Sync
      Future.delayed(const Duration(seconds: 1), () {
        getIt<SupabaseSyncService>().syncPendingData();
      });
      // No need to emit success, supplier stream updates automatically
    } catch (e) {
      emit(InventoryError('حدث خطأ أثناء إضافة المورد: $e'));
      // Restore state context if needed (users might retry)
    }
  }

  Future<void> updateBook(BooksCompanion book) async {
    try {
      await _repository.updateBookDetails(book);
      // CRITICAL: Refresh the list to reflect changes (especially re-normalization/sorting)
      loadBooks(isRefresh: true);
    } catch (e) {
      emit(InventoryError('حدث خطأ أثناء تحديث الكتاب: $e'));
    }
  }
}
