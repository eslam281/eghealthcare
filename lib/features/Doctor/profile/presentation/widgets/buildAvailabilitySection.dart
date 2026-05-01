import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../core/themes/app_colors_light.dart';
import '../../../../../core/themes/components_style.dart';
import '../../domain/entities/doctor_entity.dart';

Widget buildAvailabilitySection(DoctorEntity doctorEntity) {
  return Container(
    padding: const EdgeInsets.all(24),
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
            Icon(LucideIcons.clock, size: 20, color: AppColorsLight.primary),
            SizedBox(width: 10),
            Text(
              'Availability',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ...doctorEntity.availability!.map((day) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                day.day,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColorsLight.foreground,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColorsLight.background,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColorsLight.border.withAlpha(150)),
                ),
                child: Text(
                  'from ${day.from}     to ${day.to}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColorsLight.mutedForeground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    ),
  );
}