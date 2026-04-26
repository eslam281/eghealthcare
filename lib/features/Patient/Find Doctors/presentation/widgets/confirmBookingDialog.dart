import 'package:eghealthcare/features/Patient/Find%20Doctors/presentation/widgets/doctorInfo.dart';
import 'package:eghealthcare/features/Patient/Find%20Doctors/presentation/widgets/timeSelectionDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/doctor_entity.dart';
import '../bloc/book_appointment_bloc.dart';
import 'bookingSuccessDialog.dart';

class ConfirmBookingDialog extends StatelessWidget {
  final DoctorEntity doctor;
  final DateTime date;
  final String time;

  const ConfirmBookingDialog({
    super.key,
    required this.doctor,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookAppointmentBloc, BookAppointmentState>(
      listener: (context, state) {
        if (state is BookingSuccess) {
          Navigator.pop(context);

          showDialog(
            context: context,
            builder: (_) => BookingSuccessDialog(
              date: state.appointmentEntity.date,
              time: state.appointmentEntity.time,
            ),
          );
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 500),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Book Appointment",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      )
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// Doctor Info
                  DoctorInfo(name: doctor.name,),

                  const SizedBox(height: 10),

                  /// Summary
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _row("Date", "${date.day}/${date.month}/${date.year}"),
                        _row("Time", time),
                        _row("Type", "Consultation"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            final bloc = context.read<BookAppointmentBloc>();
                            Navigator.pop(context);

                            showDialog(
                              context: context,
                              builder: (_) => BlocProvider.value(
                                value: bloc,
                                child: TimeSelectionDialog(
                                  doctor: doctor,
                                  date: date,
                                ),
                              ),
                            );
                          },
                          child: const Text("Back"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
                          builder: (context, state) {
                            final isLoading = state is BookingLoading;

                            return ElevatedButton(
                              onPressed: isLoading ? null : () {
                                final formattedDate =
                                date.toIso8601String();

                                context.read<BookAppointmentBloc>().add(
                                  SubmitBooking(
                                    doctorId: doctor.id,
                                    date: formattedDate,
                                    time: time,
                                  ),
                                );
                              },
                              child: isLoading
                                  ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                                  : const Text("Confirm Booking"),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.grey.shade600)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}