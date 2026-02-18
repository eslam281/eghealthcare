
import 'package:eghealthcare/core/shared/state_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/patient_entity.dart';
import '../bloc/my_patients_bloc.dart';
import '../widgets/patient_card.dart' show PatientCard;

class MyPatients extends StatelessWidget {
  const MyPatients({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => MyPatientsBloc()..add(MyPatientsRequested()),
  child: Scaffold(
      appBar: AppBar(
        title: Text("My Patients",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,),
        ),
      ),
      body:SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsetsGeometry.all(8),
          child: Column(children: [
            Center(
              child: Text(
                "Browse our network of qualified healthcare professionals",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            BlocBuilder<MyPatientsBloc, MyPatientsState>(
              builder: (context, state) {
                if (state is MyPatientsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is MyPatientsLoaded) {
                  return  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120,vertical: 4),
                        child: StateCard(title: "Total Patients", count: state.patients.length,
                            color: Colors.green, icon: Icons.people),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.patients.length,
                        itemBuilder: (context, index) {
                          return PatientCard(patient: state.patients[index]);
                        }
                      )
                    ],
                  );
                }
                if (state is MyPatientsError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              }
            ),
          ],),
        ),
      ),
    ),
);
  }
}
