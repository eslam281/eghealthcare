import 'package:eghealthcare/features/Patient/Dashboard/presentation/widgets/stat_card.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entities/dashboard_summary_entity.dart';

class DashboardStatsRow extends StatelessWidget {
  final DashboardSummary summary;

  const DashboardStatsRow({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: StatCard(title: "Upcoming Appointments", value: summary.upcoming)),
        const SizedBox(width: 12),
        Expanded(child: StatCard(title: "Completed Visits", value: summary.visits)),
        const SizedBox(width: 12),
        Expanded(child: StatCard(title: "Available Doctors", value: summary.doctors)),
      ],
    );
  }
}
