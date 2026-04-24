part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  final UserRole userRole;
  LoginRequested(this.email, this.password, this.userRole);
}
final class GoogleSignInRequested extends AuthEvent {
  final UserRole userRole;
  GoogleSignInRequested(this.userRole);
}

final class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final int age;
  final String address;
  final String phoneNumber;
  final String password;
  final UserRole userRole;
  final String gender;
  RegisterRequested(this.name, this.email, this.password,this.userRole,
      this.age,this.address, this.phoneNumber, this.gender);
}

final class ResetPasswordEvent extends AuthEvent {
  final String email;
  ResetPasswordEvent(this.email);
}
final class LogoutRequested extends AuthEvent {}
final class GetUserRequested extends AuthEvent {}
