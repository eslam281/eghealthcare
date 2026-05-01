part of 'patient_profile_bloc.dart';

@immutable
sealed class PatientProfileState {}

final class PatientProfileInitial extends PatientProfileState {}
final class PatientProfileLoading extends PatientProfileState {}
final class PatientProfileLoaded extends PatientProfileState {
  final PatientProfileEntities patientProfileEntities;
  final String userID;
  PatientProfileLoaded(this.patientProfileEntities, {required this.userID});
}
final class PatientProfileError extends PatientProfileState {
  final String message;
  PatientProfileError(this.message);
}
