part of 'doctor_profile_bloc.dart';

@immutable
sealed class DoctorProfileEvent {}
final class LoadedDoctorProfileRequest implements DoctorProfileEvent{
  final String id;
  LoadedDoctorProfileRequest(this.id);
}
