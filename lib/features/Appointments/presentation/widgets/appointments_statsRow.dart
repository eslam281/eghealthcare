import 'package:flutter/material.dart';

import '../../../../core/shared/widget/state_card.dart';

class AppointmentsStatsRow extends StatelessWidget {
  final List<(String, int)> tabs;
  const AppointmentsStatsRow({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:20),
          child: StateCard(
            title: tabs[0].$1,
            count: tabs[0].$2,
            color: Colors.orange,
            icon: Icons.pending,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: StateCard(
                title: tabs[1].$1,
                count: tabs[1].$2,
                color: Colors.blue,
                icon: Icons.schedule,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: StateCard(
                title: tabs[2].$1,
                count: tabs[2].$2,
                color: Colors.green,
                icon: Icons.check_circle,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: StateCard(
                title: tabs[3].$1,
                count: tabs[3].$2,
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

