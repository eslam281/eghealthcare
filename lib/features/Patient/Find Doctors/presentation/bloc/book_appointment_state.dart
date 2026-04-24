part of 'book_appointment_bloc.dart';

@immutable
sealed class BookAppointmentState {}

class BookingInitial extends BookAppointmentState {}

class BookingLoading extends BookAppointmentState {}

class BookingSuccess extends BookAppointmentState {}

class BookingError extends BookAppointmentState {
  final String message;
  BookingError(this.message);
}