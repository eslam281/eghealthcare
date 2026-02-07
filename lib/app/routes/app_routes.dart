import 'package:eghealthcare/features/Patient/Dashboard/presentation/pages/dashboard.dart';
import 'package:eghealthcare/features/auth/presentation/pages/login.dart';
import 'package:flutter/cupertino.dart';

import '../../core/constants/routes.dart';
import '../../features/Doctor/Dashboard/presentation/pages/dashboard.dart';
import '../splash/splash_page.dart';

Map<String, Widget Function(BuildContext)> routes={
  Routes.splash: (context) => const SplashScreen(),
  Routes.register:(context) => const Login(),
  Routes.login:(context) => const Login(),
  Routes.patientDashboard:(context) => const PatientDashboard(),
  Routes.doctorDashboard:(context) => const DoctorDashboard(),
};