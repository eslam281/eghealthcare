
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/patient_profile_bloc.dart';


class PatientProfile extends StatelessWidget {
  final String id;

  const PatientProfile({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PatientProfileBloc>(
      create: (context) => PatientProfileBloc()..add(LoadedPatientProfileRequest(id)),
      child: Scaffold(

      ),
    );
  }
}
