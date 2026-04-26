part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserRole userRole;
  AuthSuccess(this.userRole);
}

final class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}
class ResetSuccess extends AuthState {
  final String message;
  ResetSuccess(this.message);
}