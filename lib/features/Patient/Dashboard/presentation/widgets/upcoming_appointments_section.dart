import 'package:flutter/cupertino.dart';

import '../../domain/entities/appointment_entity.dart';
import 'appointment_card.dart';

class UpcomingAppointmentsSection extends StatelessWidget {
  final List<AppointmentEntity> appointments;

  const UpcomingAppointmentsSection({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Upcoming Appointments",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...appointments.map((a) => AppointmentCard(appointment: a)),
      ],
    );
  }
}
