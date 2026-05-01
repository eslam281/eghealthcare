import 'package:eghealthcare/core/shared/widget/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../../injection_container.dart';
import '../../domain/entities/patientProfile_entities.dart';
import '../bloc/patient_profile_bloc.dart';

class PatientProfilePage extends StatelessWidget {
  final String id;

  const PatientProfilePage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PatientProfileBloc()
        ..add(LoadedPatientProfileRequest(id)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Patient Profile"),
        ),
        body: BlocBuilder<PatientProfileBloc, PatientProfileState>(
          builder: (context, state) {
            if (state is PatientProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PatientProfileError) {
              return Center(child: Text(state.message));
            }

            if (state is PatientProfileLoaded) {
              final PatientProfileEntities patient = state.patientProfileEntities;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [

                    /// 🔹 HEADER
                    _buildHeader(patient,state.userID),

                    const SizedBox(height: 16),

                    /// 🔹 MEDICAL + STATS
                     _buildStats(patient),
                    const SizedBox(width: 12),
                    _buildMedicalSummary(patient),

                    const SizedBox(height: 16),

                    /// 🔹 APPOINTMENTS
                    _buildAppointments(),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  /// 🔸 HEADER
  Widget _buildHeader(PatientProfileEntities patient,String userID) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            AvatarImage(imageUrl:patient.avatar, radius: 30, name: patient.name, onTap: () {} ,),

            const SizedBox(width: 16),

            /// Name + Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text("${patient.age} years old • ${patient.gender}"),
                  const SizedBox(height: 6),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text("Active Patient"),
                  )
                ],
              ),
            ),
            if(patient.id!= userID)
            ElevatedButton(
              onPressed: () {},
              child: const Text("Send Message"),
            )
          ],
        ),
      ),
    );
  }

  /// 🔸 MEDICAL SUMMARY
  Widget _buildMedicalSummary(PatientProfileEntities patient) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Medical Summary",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            Text(patient.medicalHistory ?? ""),

            const Divider(),

            _infoRow("Blood Type", patient.medicalSummary?.bloodType ?? "A+"),
            _infoRow("Allergies", patient.medicalSummary?.allergies ?? "None"),
            _infoRow("Last Visit", patient.medicalSummary?.lastVisit ?? "-"),
            _infoRow("Next Appointment", patient.medicalSummary?.nextAppointment ?? "-"),
          ],
        ),
      ),
    );
  }

  /// 🔸 STATS
  Widget _buildStats(PatientProfileEntities patient) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _statItem("Total Visits", patient.patientStats!.totalVisits.toString()),
            _statItem("Completed", patient.patientStats!.completed.toString(),
                color: Colors.green),
            _statItem("Upcoming", patient.patientStats!.upcoming.toString(),
                color: Colors.blue),
          ],
        ),
      ),
    );
  }

  /// 🔸 APPOINTMENTS
  Widget _buildAppointments() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: Text("No Appointments Yet"),
        ),
      ),
    );
  }

  /// 🔹 Helpers
  Widget _infoRow(String title, String value) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade100,
      ),
      padding: const EdgeInsets.all( 10),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _statItem(String title, String value, {Color? color}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: color ?? Colors.black)),
        ],
      ),
    );
  }
}