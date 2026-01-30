part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final User user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user.id, user.email ?? ''];
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

class AuthLicenseExpired extends AuthState {
  final DateTime? expiryDate;

  const AuthLicenseExpired(this.expiryDate);

  @override
  List<Object> get props => [expiryDate ?? DateTime(1970)];
}
