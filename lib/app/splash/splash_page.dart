import 'package:eghealthcare/app/splash/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/routes.dart';
import '../../core/themes/app_colors_dark.dart';
import '../../core/themes/app_colors_light.dart';
import '../../core/themes/is_dark_mode.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().checkAppStart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is GoToLogin) {
          Navigator.pushReplacementNamed(context, Routes.login);
        } else if (state is GoToPatientHome) {
          Navigator.pushReplacementNamed(context, Routes.patientDashboard);
        } else if (state is GoToDoctorHome) {
          Navigator.pushReplacementNamed(context, Routes.doctorDashboard);
        }
      },
      child: Scaffold(
        backgroundColor: context.isDarkMode
            ? AppColorsDark.background
            : AppColorsLight.background,
        body: const Center(
          child: FlutterLogo(size: 120),
        ),
      ),
    );
  }
}
