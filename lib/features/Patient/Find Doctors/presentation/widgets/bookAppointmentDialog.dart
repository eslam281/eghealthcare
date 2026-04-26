
import 'package:eghealthcare/features/Patient/Find%20Doctors/presentation/widgets/timeSelectionDialog.dart';
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
                      builder: (_) => BlocProvider.value(
                        value: context.read<BookAppointmentBloc>(),
                        child: TimeSelectionDialog(
                          doctor: widget.doctor,
                          date: selectedDate,
                        ),
                      ),
                    );
                  },
                  child: const Text("Continue",style: TextStyle(color:Colors.white),),
                ),
              )
            ],
          ),
        ),
      );
  }
}
