import 'package:flutter/material.dart';

import '../../../../../core/shared/stat_card.dart';

class AppointmentsStatsRow extends StatelessWidget {
  const AppointmentsStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: StatCard(
            title: "Scheduled",
            count: 3,
            color: Colors.blue,
            icon: Icons.schedule,
          ),
        ),

        SizedBox(width: 12),

        Expanded(
          child: StatCard(
            title: "Completed",
            count: 1,
            color: Colors.green,
            icon: Icons.check_circle,
          ),
        ),

        SizedBox(width: 12),

        Expanded(
          child: StatCard(
            title: "Cancelled",
            count: 0,
            color: Colors.red,
            icon: Icons.cancel,
          ),
        ),
      ],
    );
  }
}

