import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../core/shared/state_card.dart';
import '../../domain/entities/dashboard_summary_entity.dart';

class DashboardStatsRow extends StatelessWidget {
  final DashboardSummary summary;

  const DashboardStatsRow({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: StateCard(title: "Today's Appointments", count: summary.upcoming,
          icon: LucideIcons.calendar, color: Colors.blue)),
        const SizedBox(width: 12),
        Expanded(child: StateCard(title: "Total Patients", count: summary.visits,
          icon: LucideIcons.users600, color: Colors.greenAccent)),
        const SizedBox(width: 12),
        Expanded(child: StateCard(title: "Completed Today", count: summary.doctors,
          icon: LucideIcons.trendingUp600, color: Colors.green.shade500)),
      ],
    );
  }
}

