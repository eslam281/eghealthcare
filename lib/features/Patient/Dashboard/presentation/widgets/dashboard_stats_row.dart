import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../domain/entities/dashboard_summary_entity.dart';

class DashboardStatsRow extends StatelessWidget {
  final DashboardSummary summary;

  const DashboardStatsRow({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _StatCard(title: "Upcoming Appointments", value: summary.upcoming,
          icon: LucideIcons.calendar, color: Colors.blue)),
        const SizedBox(width: 12),
        Expanded(child: _StatCard(title: "Completed Visits", value: summary.visits,
          icon: LucideIcons.activity600, color: Colors.greenAccent)),
        const SizedBox(width: 12),
        Expanded(child: _StatCard(title: "Available Doctors", value: summary.doctors,
          icon: LucideIcons.stethoscope600, color: Colors.green)),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;
  final Color color;

  const _StatCard({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40, // h-9 ≈ 36px
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // rounded-lg
                  color:Colors.grey.withAlpha(40)
                ),
                child: Center(
                  child: Icon(
                    icon, size: 25, // h-5 w-5
                    color: color, // text-primary-foreground
                  ),
                ),
              )
              ,
              Text(
                value.toString(),
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: Colors.grey,),textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}

