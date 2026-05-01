import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../core/themes/app_colors_light.dart';
import '../../../../../core/themes/components_style.dart';
import '../bloc/doctor_profile_bloc.dart';

Widget buildAboutSection() {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: AppStyle.borderRadius,
      border: Border.all(color: AppColorsLight.border.withAlpha(155)),
    ),
    child: BlocBuilder<DoctorProfileBloc, DoctorProfileState>(
      builder: (context, state) {
        if (state is DoctorProfileLoaded){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(LucideIcons.user, size: 20, color: AppColorsLight.primary),
                  SizedBox(width: 10),
                  Text(
                    'About',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(color: AppColorsLight.border),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: _buildInfoBox('Specialty', state.doctorEntity.specialty)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildInfoBox('Experience', state.doctorEntity.experience ?? 'N/A')),
                ],
              ),
              if (state.doctorEntity.bio != null && state.doctorEntity.bio!.isNotEmpty) ...[
                const SizedBox(height: 24),
                Text(
                  state.doctorEntity.bio!,
                  style: const TextStyle(
                    color: AppColorsLight.mutedForeground,
                    height: 1.6,
                    fontSize: 15,
                  ),
                ),
              ] else ...[
                const SizedBox(height: 24),
                const Text(
                  'This doctor has not provided a biography yet.',
                  style: TextStyle(
                    color: AppColorsLight.mutedForeground,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          );}
        return const SizedBox();
      },
    ),
  );
}
Widget _buildInfoBox(String title, String value) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColorsLight.background,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColorsLight.border.withAlpha(75)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: AppColorsLight.mutedForeground, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColorsLight.foreground,
          ),
        ),
      ],
    ),
  );
}