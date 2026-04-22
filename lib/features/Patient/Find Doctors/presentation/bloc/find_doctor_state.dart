part of 'find_doctor_bloc.dart';

@immutable
sealed class FindDoctorState {}

final class FindDoctorInitial extends FindDoctorState {}
final class FindDoctorLoading extends FindDoctorState {}
final class FindDoctorLoaded extends FindDoctorState{
  final List<DoctorEntity> doctors;
  FindDoctorLoaded(this.doctors);
}
final class FindDoctorError extends FindDoctorState{
  final String message;
  FindDoctorError(this.message);
}
