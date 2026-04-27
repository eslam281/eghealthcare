part of 'find_doctor_bloc.dart';

@immutable
sealed class FindDoctorEvent {}
class LoadDoctorRequested extends FindDoctorEvent {}
class RefreshDoctorRequested extends FindDoctorEvent {}
class SearchRequested extends FindDoctorEvent {
  final String query;
  SearchRequested(this.query);
}

