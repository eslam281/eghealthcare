import 'package:eghealthcare/features/Patient/Dashboard/presentation/pages/dashboard.dart';
import 'package:eghealthcare/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/cupertino.dart';

import '../../core/constants/routes.dart';
import '../../features/Doctor/Dashboard/presentation/pages/dashboard.dart';
import '../../features/Patient/Find Doctors/presentation/pages/find_doctor.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../splash/splash_page.dart';

Map<String, Widget Function(BuildContext)> routes={
  Routes.splash: (context) => const SplashScreen(),
  /////
  Routes.register:(context) => const RegisterPage(),
  Routes.login:(context) => const LoginPage(),
  /////
  Routes.patientDashboard:(context) => const PatientDashboard(),
  Routes.findDoctor:(context) => const FindDoctorsPage(),
  /////
  Routes.doctorDashboard:(context) => const DoctorDashboard(),
};