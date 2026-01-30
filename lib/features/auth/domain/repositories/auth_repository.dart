import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  Future<User?> signIn({required String email, required String password});
  Future<User?> signUp({
    required String email,
    required String password,
    required String libraryName,
    required String licenseKey,
  });
  Future<void> signOut();
  User? getCurrentUser();
  Stream<AuthState> get authStateChanges;

  /// Activates a license key via Supabase RPC.
  /// Returns a Map with {success, expiry_date, status, message}.
  Future<Map<String, dynamic>> activateLicense(String key);
}
