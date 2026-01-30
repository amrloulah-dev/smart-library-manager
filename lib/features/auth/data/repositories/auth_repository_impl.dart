import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:librarymanager/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _supabaseClient; //LIB-2025-5BAE-3CA0

  AuthRepositoryImpl(this._supabaseClient);

  @override
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    return _retryAuthCall(() async {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.user;
    });
  }

  @override
  Future<User?> signUp({
    required String email,
    required String password,
    required String libraryName,
    required String licenseKey,
  }) async {
    return _retryAuthCall(() async {
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'library_name': libraryName, 'license_key': licenseKey},
      );
      return response.user;
    });
  }

  @override
  Future<void> signOut() async {
    // Sign out is local + server, usually less critical to retry but good practice if we want consistency
    await _supabaseClient.auth.signOut();
  }

  @override
  User? getCurrentUser() {
    return _supabaseClient.auth.currentUser;
  }

  @override
  Stream<AuthState> get authStateChanges {
    return _supabaseClient.auth.onAuthStateChange;
  }

  @override
  Future<Map<String, dynamic>> activateLicense(String key) async {
    return _retryAuthCall(() async {
      final response = await _supabaseClient.rpc(
        'activate_license',
        params: {'input_key': key},
      );
      // The RPC returns JSON: {success, expiry_date, status, message}
      if (response is Map<String, dynamic>) {
        return response;
      }
      // Handle unexpected response format
      return {
        'success': false,
        'message': 'Unexpected response format from server',
      };
    });
  }

  Future<T> _retryAuthCall<T>(
    Future<T> Function() call, {
    int retries = 3,
  }) async {
    int attempts = 0;
    while (true) {
      try {
        attempts++;
        return await call();
      } catch (e) {
        // Handle "Connection closed before full header was received" or similar network glitches
        if (attempts < retries && e.toString().contains('Connection closed')) {
          await Future.delayed(const Duration(milliseconds: 1000));
          continue;
        }
        rethrow;
      }
    }
  }
}
