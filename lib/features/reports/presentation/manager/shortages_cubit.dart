import 'package:flutter/services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/operations/domain/repositories/reservations_repository.dart';
// inventory_repository is no longer needed for shortages, as we use straight BI logic
// but we might keep the import if other methods used it, but here we only had fetchShortages.
import 'package:librarymanager/features/reports/domain/services/business_intelligence_service.dart';
import 'package:librarymanager/core/database/daos/books_dao.dart';

part 'shortages_state.dart';

@injectable
class ShortagesCubit extends Cubit<ShortagesState> {
  final ReservationsRepository _reservationsRepository;
  final BusinessIntelligenceService _biService;
  final BooksDao _booksDao;

  ShortagesCubit(this._reservationsRepository, this._biService, this._booksDao)
    : super(ShortagesInitial()) {
    fetchSmartShortages();
  }

  Future<void> fetchSmartShortages() async {
    emit(ShortagesLoading());
    try {
      // 1. Fetch Data
      final reservations = await _reservationsRepository
          .getPendingReservations();
      final allBooks = await _booksDao.streamAllBooks().first;

      // Map books for easy lookup
      final Map<String, Book> bookMap = {for (var b in allBooks) b.name: b};

      final List<ShortageItem> unifiedItems = [];

      // 2. Process Reservations (High Priority)
      for (final res in reservations) {
        final book = bookMap[res.bookName];
        unifiedItems.add(
          ShortageItem(
            type: ShortageType.reservation,
            reservation: res,
            book: book,
            quantity: 1,
            reason: 'محجوز للعميل: ${res.customerName}',
          ),
        );
      }

      // 3. Process Out of Stock items (Direct Shortages)
      final reservedBookNames = reservations.map((r) => r.bookName).toSet();
      for (final book in allBooks) {
        if (book.currentStock == 0 && !reservedBookNames.contains(book.name)) {
          unifiedItems.add(
            ShortageItem(
              type: ShortageType.outOfStock,
              book: book,
              quantity: book.minLimit > 0 ? book.minLimit : 5,
              reason: 'نفذت الكمية (خارج المخزون)',
            ),
          );
        }
      }

      // 4. Process AI Restock Suggestions
      final processedBookIds = unifiedItems
          .where((i) => i.book != null)
          .map((i) => i.book!.id)
          .toSet();

      for (final book in allBooks) {
        if (processedBookIds.contains(book.id)) continue;

        final suggestion = await _biService.generateRestockSuggestion(book);

        if (suggestion.suggestedOrder > 0) {
          unifiedItems.add(
            ShortageItem(
              type: ShortageType.smartRestock,
              book: book,
              quantity: suggestion.suggestedOrder,
              reason: suggestion.reasoning,
              confidence: suggestion.confidence,
            ),
          );
        }
      }

      // 5. Sort: Reservations first, then Out of Stock, then Smart Restock
      unifiedItems.sort((a, b) {
        if (a.type != b.type) {
          return a.type.index.compareTo(b.type.index);
        }
        return b.quantity.compareTo(a.quantity);
      });

      emit(ShortagesLoaded(items: unifiedItems));
    } catch (e) {
      emit(ShortagesError(e.toString()));
    }
  }

  String generateWhatsAppText() {
    final state = this.state;
    if (state is! ShortagesLoaded) return '';

    StringBuffer buffer = StringBuffer();
    buffer.writeln('*قائمة النواقص الذكية:*');
    buffer.writeln('');

    final reservations = state.items
        .where((i) => i.type == ShortageType.reservation)
        .toList();
    final outOfStock = state.items
        .where((i) => i.type == ShortageType.outOfStock)
        .toList();
    final suggestions = state.items
        .where((i) => i.type == ShortageType.smartRestock)
        .toList();

    if (reservations.isNotEmpty) {
      buffer.writeln('*-- طلبات العملاء --*');
      for (int i = 0; i < reservations.length; i++) {
        final item = reservations[i];
        buffer.writeln(
          '${i + 1}. ${item.reservation?.bookName} - (للعميل: ${item.reservation?.customerName})',
        );
      }
      buffer.writeln('');
    }

    if (outOfStock.isNotEmpty) {
      buffer.writeln('*-- كتب نفذت (0) --*');
      for (int i = 0; i < outOfStock.length; i++) {
        final item = outOfStock[i];
        if (item.book != null) {
          buffer.writeln(
            '${i + 1}. ${item.book!.name} - (مطلوب: ${item.quantity})',
          );
        }
      }
      buffer.writeln('');
    }

    if (suggestions.isNotEmpty) {
      buffer.writeln('*-- مقترحات التوريد --*');
      for (int i = 0; i < suggestions.length; i++) {
        final item = suggestions[i];
        if (item.book != null) {
          buffer.writeln(
            '${i + 1}. ${item.book!.name} - (الطلب: ${item.quantity}) - ${item.reason}',
          );
        }
      }
    }

    return buffer.toString();
  }

  Future<void> sendToWhatsApp() async {
    final text = generateWhatsAppText();
    if (text.isEmpty) return;

    final encodedText = Uri.encodeComponent(text);
    final url = Uri.parse('whatsapp://send?text=$encodedText');

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        await Clipboard.setData(ClipboardData(text: text));
      }
    } catch (e) {
      await Clipboard.setData(ClipboardData(text: text));
    }
  }
}
