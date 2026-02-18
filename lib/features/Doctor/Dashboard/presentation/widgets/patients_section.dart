import 'package:eghealthcare/features/Doctor/Dashboard/presentation/widgets/patient_card.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/patient_entity.dart';

class PatientsSection extends StatelessWidget {
  final List<PatientEntity> patients;

  const PatientsSection({
    super.key,
    required this.patients,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "My Patients",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      "View All",
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 15,
                        color: Theme.of(context).colorScheme.onSurfaceVariant
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// Patients List (Preview only)
          ListView.builder(
            itemCount: patients.length > 2 ? 2 : patients.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return PatientCard(patient: patients[index]);
            },
          ),
        ],
      ),
    );
  }
}
