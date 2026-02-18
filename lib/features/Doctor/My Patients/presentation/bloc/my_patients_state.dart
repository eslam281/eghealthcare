part of 'my_patients_bloc.dart';

@immutable
sealed class MyPatientsState {}

final class MyPatientsInitial extends MyPatientsState {}
final class MyPatientsLoading extends MyPatientsState {}
final class MyPatientsLoaded extends MyPatientsState{
  final List<PatientEntity> patients;

  MyPatientsLoaded(this.patients);
}
final class MyPatientsError extends MyPatientsState {
  final String message;

  MyPatientsError(this.message);
}
