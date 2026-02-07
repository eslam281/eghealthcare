part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class GoToLogin extends SplashState {}

class GoToDoctorHome extends SplashState {}

class GoToPatientHome extends SplashState {}
