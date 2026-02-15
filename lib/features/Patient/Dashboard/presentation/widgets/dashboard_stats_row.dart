import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../core/shared/stat_card.dart';
import '../../domain/entities/dashboard_summary_entity.dart';

class DashboardStatsRow extends StatelessWidget {
  final DashboardSummary summary;

  const DashboardStatsRow({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: StatCard(title: "Upcoming Appointments", count: summary.upcoming,
          icon: LucideIcons.calendar, color: Colors.blue)),
        const SizedBox(width: 12),
        Expanded(child: StatCard(title: "Completed Visits", count: summary.visits,
          icon: LucideIcons.activity600, color: Colors.greenAccent)),
        const SizedBox(width: 12),
        Expanded(child: StatCard(title: "Available Doctors", count: summary.doctors,
          icon: LucideIcons.stethoscope600, color: Colors.green)),
      ],
    );
  }
}

