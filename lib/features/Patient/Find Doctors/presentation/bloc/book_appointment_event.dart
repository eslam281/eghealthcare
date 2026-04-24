part of 'book_appointment_bloc.dart';

@immutable
sealed class BookAppointmentEvent {}

class SubmitBooking extends BookAppointmentEvent {
  final String doctorId;
  final DateTime date;
  final String time;

  SubmitBooking({
    required this.doctorId,
    required this.date,
    required this.time,
  });
}