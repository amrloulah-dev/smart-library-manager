import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/operations/domain/repositories/reservations_repository.dart';

@LazySingleton(as: ReservationsRepository)
class ReservationsRepositoryImpl implements ReservationsRepository {
  final AppDatabase _db;

  ReservationsRepositoryImpl(this._db);

  @override
  Stream<List<Reservation>> streamReservations() {
    return (_db.select(_db.reservations)..orderBy([
          (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
        ]))
        .watch();
  }

  @override
  Future<void> addReservation({
    required String customerName,
    required String phone,
    required String bookName,
    required double deposit,
    String? bookId,
  }) {
    return _db.transaction(() async {
      await _db
          .into(_db.reservations)
          .insert(
            ReservationsCompanion(
              customerName: Value(customerName),
              phone: Value(phone),
              bookName: Value(bookName),
              bookId: bookId == null ? const Value.absent() : Value(bookId),
              deposit: Value(deposit),
              status: const Value('Pending'),
              createdAt: Value(DateTime.now()),
            ),
          );

      if (bookId != null) {
        // Increment reserved quantity in books table
        final book = await (_db.select(
          _db.books,
        )..where((t) => t.id.equals(bookId))).getSingleOrNull();
        if (book != null) {
          await (_db.update(
            _db.books,
          )..where((t) => t.id.equals(bookId))).write(
            BooksCompanion(reservedQuantity: Value(book.reservedQuantity + 1)),
          );
        }
      }
    });
  }

  @override
  Future<void> updateStatus(String id, String status) {
    return _db.transaction(() async {
      final reservation = await (_db.select(
        _db.reservations,
      )..where((t) => t.id.equals(id))).getSingleOrNull();

      if (reservation != null &&
          reservation.status == 'Pending' &&
          status != 'Pending' &&
          reservation.bookId != null) {
        // Decrement reserved quantity
        final book = await (_db.select(
          _db.books,
        )..where((t) => t.id.equals(reservation.bookId!))).getSingleOrNull();
        if (book != null && book.reservedQuantity > 0) {
          await (_db.update(
            _db.books,
          )..where((t) => t.id.equals(reservation.bookId!))).write(
            BooksCompanion(reservedQuantity: Value(book.reservedQuantity - 1)),
          );
        }
      }

      await (_db.update(_db.reservations)..where((t) => t.id.equals(id))).write(
        ReservationsCompanion(status: Value(status)),
      );
    });
  }

  @override
  Future<void> linkBookToReservation(String reservationId, String bookId) {
    return _db.transaction(() async {
      final reservation = await (_db.select(
        _db.reservations,
      )..where((t) => t.id.equals(reservationId))).getSingleOrNull();

      if (reservation != null &&
          reservation.status == 'Pending' &&
          reservation.bookId == null) {
        // Increment reserved quantity for the newly linked book
        final book = await (_db.select(
          _db.books,
        )..where((t) => t.id.equals(bookId))).getSingleOrNull();
        if (book != null) {
          await (_db.update(
            _db.books,
          )..where((t) => t.id.equals(bookId))).write(
            BooksCompanion(reservedQuantity: Value(book.reservedQuantity + 1)),
          );
        }
      }

      await (_db.update(_db.reservations)
            ..where((t) => t.id.equals(reservationId)))
          .write(ReservationsCompanion(bookId: Value(bookId)));
    });
  }

  @override
  Future<List<Reservation>> getPendingReservations() {
    return (_db.select(
      _db.reservations,
    )..where((t) => t.status.equals('Pending'))).get();
  }

  @override
  Future<void> deleteReservation(String id) {
    return _db.transaction(() async {
      final reservation = await (_db.select(
        _db.reservations,
      )..where((t) => t.id.equals(id))).getSingleOrNull();

      if (reservation != null &&
          reservation.status == 'Pending' &&
          reservation.bookId != null) {
        // Decrement reserved quantity
        final book = await (_db.select(
          _db.books,
        )..where((t) => t.id.equals(reservation.bookId!))).getSingleOrNull();
        if (book != null && book.reservedQuantity > 0) {
          await (_db.update(
            _db.books,
          )..where((t) => t.id.equals(reservation.bookId!))).write(
            BooksCompanion(reservedQuantity: Value(book.reservedQuantity - 1)),
          );
        }
      }
      await (_db.delete(_db.reservations)..where((t) => t.id.equals(id))).go();
    });
  }
}
