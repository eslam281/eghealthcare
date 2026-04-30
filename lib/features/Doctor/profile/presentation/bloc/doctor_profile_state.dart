part of 'doctor_profile_bloc.dart';

@immutable
sealed class DoctorProfileState {}

final class DoctorProfileInitial extends DoctorProfileState {}
final class DoctorProfileLoading extends DoctorProfileState {}
final class DoctorProfileLoaded extends DoctorProfileState {
  final DoctorEntity doctorEntity;
  DoctorProfileLoaded(this.doctorEntity);
}
