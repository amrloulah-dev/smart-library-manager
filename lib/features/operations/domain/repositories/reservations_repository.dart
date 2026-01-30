import 'package:librarymanager/core/database/app_database.dart';

abstract class ReservationsRepository {
  Stream<List<Reservation>> streamReservations();
  Future<void> addReservation({
    required String customerName,
    required String phone,
    required String bookName,
    required double deposit,
    String? bookId,
  });
  Future<void> updateStatus(String id, String status);
  Future<void> linkBookToReservation(String reservationId, String bookId);
  Future<List<Reservation>> getPendingReservations();
  Future<void> deleteReservation(String id);
}
