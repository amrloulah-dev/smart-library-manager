import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:librarymanager/features/auth/domain/repositories/auth_repository.dart';
import 'package:librarymanager/core/database/daos/smart_settings_dao.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final SmartSettingsDao _smartSettingsDao;

  AuthCubit(this._authRepository, this._smartSettingsDao)
    : super(AuthLoading()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    try {
      final user = _authRepository.getCurrentUser();

      if (user != null) {
        final licenseInfo = await _smartSettingsDao.getLicenseInfo();
        if (licenseInfo.expiry != null &&
            licenseInfo.expiry!.isBefore(DateTime.now())) {
          emit(AuthLicenseExpired(licenseInfo.expiry));
        } else {
          emit(Authenticated(user));
        }
      } else {
        emit(Unauthenticated());
      }

      // Setup listener for future changes
      _authRepository.authStateChanges.listen((data) async {
        final session = data.session;
        final currentUser = session?.user;

        if (currentUser != null) {
          final licenseInfo = await _smartSettingsDao.getLicenseInfo();
          if (licenseInfo.expiry != null &&
              licenseInfo.expiry!.isBefore(DateTime.now())) {
            emit(AuthLicenseExpired(licenseInfo.expiry));
            return;
          }

          // Avoid duplicate emissions
          if (state is Authenticated &&
              (state as Authenticated).user.id == currentUser.id) {
            return;
          }
          emit(Authenticated(currentUser));
        } else {
          if (state is Unauthenticated) return;
          emit(Unauthenticated());
        }
      });
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await _authRepository.signIn(email: email, password: password);
      // The listener will update the state
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String libraryName,
    required String licenseKey,
  }) async {
    emit(AuthLoading());
    try {
      // Step 1: Create the user account
      final user = await _authRepository.signUp(
        email: email,
        password: password,
        libraryName: libraryName,
        licenseKey: licenseKey,
      );

      if (user == null) {
        emit(const AuthError('فشل إنشاء الحساب. حاول مرة أخرى.'));
        return;
      }

      // Step 2: Activate the license key via RPC
      final licenseResponse = await _authRepository.activateLicense(licenseKey);

      if (licenseResponse['success'] == true) {
        // License is valid - store locally for offline access
        final expiryDateStr = licenseResponse['expiry_date'] as String?;
        final status = licenseResponse['status'] as String? ?? 'active';

        if (expiryDateStr != null) {
          final expiryDate = DateTime.parse(expiryDateStr);
          await _smartSettingsDao.updateLicenseInfo(
            key: licenseKey,
            expiry: expiryDate,
            status: status,
          );
        }

        // Emit authenticated state
        emit(Authenticated(user));
      } else {
        // License is invalid - sign out immediately
        final message =
            licenseResponse['message'] as String? ?? 'مفتاح الترخيص غير صالح';
        await _authRepository.signOut();
        emit(AuthError(message));
      }
    } catch (e) {
      // On any error, ensure user is signed out
      try {
        await _authRepository.signOut();
      } catch (_) {}
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      // Clear license info when signing out
      await _smartSettingsDao.clearLicenseInfo();
      await _authRepository.signOut();
      // The listener will update the state
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
