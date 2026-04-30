import 'package:eghealthcare/core/themes/app_colors_light.dart';
import 'package:eghealthcare/core/themes/components_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../bloc/doctor_profile_bloc.dart';
import '../widgets/buildAboutSection.dart';
import '../widgets/buildAvailabilitySection.dart';
import '../widgets/buildHeaderCard.dart';


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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeaderCard(context),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 900) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: buildAboutSection()),
                      const SizedBox(width: 24),
                      Expanded(flex: 1, child: buildAvailabilitySection()),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      buildAboutSection(),
                      const SizedBox(height: 24),
                      buildAvailabilitySection(),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 24),
            _buildReviewsSection(),
          ],
        ),
      ),
      ),
    );
  }



  Widget _buildReviewsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppStyle.borderRadius,
        border: Border.all(color: AppColorsLight.border.withAlpha(150)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(LucideIcons.messageSquare, size: 20, color: AppColorsLight.primary),
              SizedBox(width: 10),
              Text(
                'Patient Reviews (0)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColorsLight.foreground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: AppColorsLight.background,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    LucideIcons.messageSquare,
                    size: 40,
                    color: AppColorsLight.mutedForeground.withAlpha(120),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'No reviews yet',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColorsLight.foreground,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Be the first to leave a review for this doctor.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColorsLight.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
