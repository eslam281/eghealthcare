import 'package:flutter/material.dart';

import '../widgets/diagnosisList.dart';
import '../widgets/diagnosis_statsRow.dart';

class DiagnosisHistorySection extends StatelessWidget {
  const DiagnosisHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Diagnosis History",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "View your complete medical diagnosis history",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
        
            SizedBox(height: 16),
        
            DiagnosisStatsRow(),
        
            SizedBox(height: 16),
        
            DiagnosisList(),
        
          ],
        ),
      ),
    );
  }
}
