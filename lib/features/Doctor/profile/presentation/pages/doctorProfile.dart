import 'package:eghealthcare/core/themes/app_colors_light.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../bloc/doctor_profile_bloc.dart';
import '../widgets/buildAboutSection.dart';
import '../widgets/buildAvailabilitySection.dart';
import '../widgets/buildHeaderCard.dart';
import '../widgets/buildReviewsSection.dart';


class DoctorProfile extends StatelessWidget {
  final String id;

  const DoctorProfile({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorProfileBloc>(
      create: (context) => DoctorProfileBloc()..add(LoadedDoctorProfileRequest(id)),
      child: Scaffold(
      backgroundColor: AppColorsLight.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, color: AppColorsLight.foreground),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Doctor Profile',
          style: TextStyle(
            color: AppColorsLight.foreground,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<DoctorProfileBloc, DoctorProfileState>(
            builder: (context, state) {
              if (state is DoctorProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is DoctorProfileError) {
                return Center(child: Text(state.message));
              }
              if (state is DoctorProfileLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeaderCard(context, state.doctorEntity),
                    const SizedBox(height: 24),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth > 900) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 2,
                                  child: buildAboutSection(state.doctorEntity)),
                              const SizedBox(width: 24),
                              Expanded(
                                  flex: 1, child: buildAvailabilitySection(state.doctorEntity)),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              buildAboutSection(state.doctorEntity),
                              const SizedBox(height: 24),
                              buildAvailabilitySection(state.doctorEntity),
                            ],
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    buildReviewsSection(state.doctorEntity),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
