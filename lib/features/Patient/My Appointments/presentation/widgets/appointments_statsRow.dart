import 'package:flutter/material.dart';

class AppointmentsStatsRow extends StatelessWidget {
  const AppointmentsStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _AppointmentStatCard(
            title: "Scheduled",
            count: 3,
            color: Colors.blue,
            icon: Icons.schedule,
          ),
        ),

        SizedBox(width: 12),

        Expanded(
          child: _AppointmentStatCard(
            title: "Completed",
            count: 1,
            color: Colors.green,
            icon: Icons.check_circle,
          ),
        ),

        SizedBox(width: 12),

        Expanded(
          child: _AppointmentStatCard(
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
class _AppointmentStatCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final IconData icon;

  const _AppointmentStatCard({
    required this.title,
    required this.count,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color),
              ),

              const SizedBox(width: 12),

                  Text(
                    count.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

            ],
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

