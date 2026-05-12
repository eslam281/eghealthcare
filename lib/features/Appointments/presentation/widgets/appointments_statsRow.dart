import 'package:flutter/material.dart';

import '../../../../core/shared/widget/state_card.dart';
import '../bloc/appointments_bloc.dart';

class AppointmentsStatsRow extends StatelessWidget {
  final Map<AppointmentFilter, int> counts;

  const AppointmentsStatsRow({super.key, required this.counts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: StateCard(
            title: AppointmentFilter.pending.title,
            count: counts[AppointmentFilter.pending] ?? 0,
            color: Colors.orange,
            icon: Icons.pending,
          ),
        ),

        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StateCard(
                title: AppointmentFilter.scheduled.title,
                count: counts[AppointmentFilter.scheduled] ?? 0,
                color: Colors.blue,
                icon: Icons.schedule,
              ),
            ),

            const SizedBox(width: 12),
            Expanded(
              child: StateCard(
                title: AppointmentFilter.completed.title,
                count: counts[AppointmentFilter.completed] ?? 0,
                color: Colors.green,
                icon: Icons.check_circle,
              ),
            ),

            const SizedBox(width: 12),
            Expanded(
              child: StateCard(
                title: AppointmentFilter.cancelled.title,
                count: counts[AppointmentFilter.cancelled] ?? 0,
                color: Colors.red,
                icon: Icons.cancel,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
