import 'package:eghealthcare/features/Patient/Find%20Doctors/presentation/widgets/doctorInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/doctor_entity.dart';
import '../bloc/book_appointment_bloc.dart';
import 'bookAppointmentDialog.dart';
import 'confirmBookingDialog.dart';

class TimeSelectionDialog extends StatefulWidget {
  final DoctorEntity doctor;
  final DateTime date;

  const TimeSelectionDialog({
    super.key,
    required this.doctor,
    required this.date,
  });

  @override
  State<TimeSelectionDialog> createState() => _TimeSelectionDialogState();
}

class _TimeSelectionDialogState extends State<TimeSelectionDialog> {
  String? selectedTime;

  final List<String> timeSlots = [
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "02:00 PM",
    "02:30 PM",
    "03:00 PM",
    "03:30 PM",
    "04:00 PM",
    "04:30 PM",
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Book Appointment",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                )
              ],
            ),

            const SizedBox(height: 10),

            /// Doctor Info
            DoctorInfo(name: widget.doctor.name,),

            const SizedBox(height: 10),

            /// Date
            Text(
              "${widget.date.day}/${widget.date.month}/${widget.date.year}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            /// Time Grid
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: timeSlots.map((time) {
                final isSelected = selectedTime == time;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTime = time;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: isSelected ? Colors.white : Colors.grey,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          time,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
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
                          child: BookAppointmentDialog(
                            doctor:widget.doctor,
                          ),
                        ),
                      );
                    },
                    child: const Text("Back"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: selectedTime == null ? null
                        : () {
                      final bloc = context.read<BookAppointmentBloc>();
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (_) {
                          return BlocProvider.value(
                            value:bloc,
                            child: ConfirmBookingDialog(
                              doctor: widget.doctor,
                              date: widget.date,
                              time: selectedTime!,
                            ),
                          );
                        },
                      );
                    },
                    child: const Text("Continue"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}