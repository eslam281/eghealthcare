part of 'patient_profile_bloc.dart';

@immutable
sealed class PatientProfileState {}

final class PatientProfileInitial extends PatientProfileState {}
final class PatientProfileLoading extends PatientProfileState {}
final class PatientProfileLoaded extends PatientProfileState {
  final PatientProfileEntities patientProfileEntities;
  PatientProfileLoaded(this.patientProfileEntities);
}
final class PatientProfileError extends PatientProfileState {
  final String message;
  PatientProfileError(this.message);
}
