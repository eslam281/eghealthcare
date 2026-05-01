part of 'patient_profile_bloc.dart';

@immutable
sealed class PatientProfileEvent {}
class LoadedPatientProfileRequest extends PatientProfileEvent {
  final String id;
  LoadedPatientProfileRequest(this.id);
}
