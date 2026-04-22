part of 'find_doctor_bloc.dart';

@immutable
sealed class FindDoctorEvent {}
class LoadDoctorRequested extends FindDoctorEvent {}
class RefreshDoctorRequested extends FindDoctorEvent {}

