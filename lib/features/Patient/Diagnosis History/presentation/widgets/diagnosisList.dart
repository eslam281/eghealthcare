import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class DiagnosisList extends StatelessWidget {
  const DiagnosisList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, index) {
        return const _DiagnosisItemCard();
      },
    );
  }
}
class _DiagnosisItemCard extends StatelessWidget {
  const _DiagnosisItemCard({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          /// Top Row
          Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Doctor Image
            const CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(
                "https://i.pravatar.cc/150?img=47",
              ),
            ),

            const SizedBox(width: 12),

            /// Name + Speciality
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Dr. Sarah Mitchell",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    "Cardiologist",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),

                ],
              ),
            ),

            /// Status Badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.orange.withAlpha(25),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Ongoing",
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

          ],
        ),

        const SizedBox(height: 16),

        /// Diagnosis Title
        const Row(
          children: [

            Icon(LucideIcons.stethoscope,
                size: 18, color: Colors.teal),

            SizedBox(width: 8),

            Text(
              "Hypertension Stage 1",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),

        const SizedBox(height: 6),

        /// Date
        const Row(
          children: [

            Icon(Icons.calendar_today,
                size: 14, color: Colors.grey),

            SizedBox(width: 6),

            Text(
              "January 15, 2025",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),

          ],
        ),

        const SizedBox(height: 12),

        /// Description
        const Text(
          "Blood pressure readings consistently above 130/80 mmHg. "
              "Patient shows signs of mild hypertension requiring lifestyle "
              "modifications and medication.",
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 16),

        /// Treatment Box
        Container(
          padding: const EdgeInsets.all(12),

          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
          ),

          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [

                  Icon(Icons.medication,
                      size: 16, color: Colors.teal),

                  SizedBox(width: 6),

                  Text(
                    "Treatment",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 6),

              Text(
                "Prescribed Lisinopril 10mg daily. "
                    "Recommended low-sodium diet and regular exercise.",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),

            ],
          ),
        ),

        const SizedBox(height: 16),

        /// Bottom Button
        Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                  Text("View Doctor"),

              SizedBox(width: 4),

                    Icon(Icons.arrow_forward, size: 16),

                  ],
              ),
            ),
        ),

          ],
        ),
    );
  }
}