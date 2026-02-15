import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../core/shared/state_card.dart';

class DiagnosisStatsRow extends StatelessWidget {
  const DiagnosisStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [

        Expanded(
          child: StateCard(
            title: "Ongoing",
            count: 1,
            icon: LucideIcons.activity600,
            color: Colors.orange,
          ),
        ),

        SizedBox(width: 12),

        Expanded(
          child: StateCard(
            title: "Resolved",
            count: 2,
            icon: Icons.description,
            color: Colors.green,
          ),
        ),

        SizedBox(width: 12),

        Expanded(
          child: StateCard(
            title: "Follow-up",
            count: 0,
            icon: Icons.calendar_today,
            color: Colors.blue,
          ),
        ),

      ],
    );
  }
}
