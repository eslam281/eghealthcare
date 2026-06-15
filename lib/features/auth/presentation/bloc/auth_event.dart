part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested(this.email, this.password);
}
final class GoogleSignInRequested extends AuthEvent {}

final class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final int age;
  final String address;
  final String phoneNumber;
  final String password;
  final UserRole userRole;
  final String gender;
  final String? specialty;
  final List<Map<String, String>>? availability;
  RegisterRequested(this.name, this.email, this.password,this.userRole,
      this.age,this.address, this.phoneNumber, this.gender, {this.specialty, this.availability});
}

final class ResetPasswordEvent extends AuthEvent {
  final String email;
  ResetPasswordEvent(this.email);
}
final class LogoutRequested extends AuthEvent {}
final class GetUserRequested extends AuthEvent {}
