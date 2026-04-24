
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/doctor_entity.dart';
import '../bloc/book_appointment_bloc.dart';

class BookAppointmentDialog extends StatefulWidget {
  final DoctorEntity doctor;

  const BookAppointmentDialog({super.key, required this.doctor});

  @override
  State<BookAppointmentDialog> createState() => _BookAppointmentDialogState();
}

class _BookAppointmentDialogState extends State<BookAppointmentDialog> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => BookAppointmentBloc(),
  child: Dialog(
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade100,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.greenAccent.withAlpha(30),
                  child: Text(widget.doctor.name[0],style:
                  TextStyle(color: Colors.green.withGreen(190)),),
                ),
                title: Text("Dr. ${widget.doctor.name}"),
              ),
            ),

            const SizedBox(height: 10),

            /// Calendar
            CalendarDatePicker(
              initialDate: selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime(2030),
              onDateChanged: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),

            const SizedBox(height: 10),

            /// Continue
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor:
                Colors.greenAccent.withAlpha(100)),
                onPressed:() {
                  Navigator.pop(context);

                  showDialog(
                    context: context,
                    builder: (_) => TimeSelectionDialog(
                      doctor: widget.doctor,
                      date: selectedDate,
                    ),
                  );
                },
                child: const Text("Continue",style: TextStyle(color:Colors.white),),
              ),
            )
          ],
        ),
      ),
    ),
);
  }
}

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
            ListTile(
              leading: CircleAvatar(
                child: Text(widget.doctor.name[0]),
              ),
              title: Text("Dr. ${widget.doctor.name}"),
            ),

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
                      Navigator.pop(context);
                    },
                    child: const Text("Back"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: selectedTime == null
                        ? null
                        : () {
                      Navigator.pop(context);

                      showDialog(
                        context: context,
                        builder: (_) => ConfirmBookingDialog(
                          doctor: widget.doctor,
                          date: widget.date,
                          time: selectedTime!,
                        ),
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
            ListTile(
              leading: CircleAvatar(
                child: Text(doctor.name[0]),
              ),
              title: Text("Dr. ${doctor.name}"),
            ),

            const SizedBox(height: 10),

            /// Summary Box
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
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Back"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<BookAppointmentBloc>().add(
                        SubmitBooking(
                          doctorId: doctor.id,
                          date: date,
                          time: time,
                        ),
                      );
                    },
                    child: const Text("Confirm Booking"),
                  ),
                ),
              ],
            )
          ],
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