import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../core/themes/app_colors_light.dart';
import '../../../../../core/themes/components_style.dart';
import '../../domain/entities/doctor_entity.dart';

Widget buildReviewsSection(DoctorEntity doctorEntity) {
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
        Row(
          children: [
            const Icon(LucideIcons.messageSquare, size: 20, color: AppColorsLight.primary),
            const SizedBox(width: 10),
            Text(
              'Patient Reviews (${doctorEntity.reviews?.length??0})',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColorsLight.foreground,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 16),
              (doctorEntity.reviews == null || doctorEntity.reviews!.isEmpty)
                  ? Column(
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
              )
                  : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: doctorEntity.reviews!.length,
                separatorBuilder: (_, _) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final review = doctorEntity.reviews![index];
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColorsLight.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColorsLight.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// 🔹 Header (Name + Date)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              review.patientName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: AppColorsLight.foreground,
                              ),
                            ),
                            Text(
                              DateFormat('dd MMM yyyy').format(review.date),
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColorsLight.mutedForeground,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        /// 🔹 Rating Stars
                        Row(
                          children: List.generate(5, (i) {
                            return Icon(
                              i < review.rating ? Icons.star : Icons.star_border,
                              size: 16,
                              color: Colors.amber,
                            );
                          }),
                        ),

                        const SizedBox(height: 8),

                        /// 🔹 Comment
                        Text(
                          review.comment,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColorsLight.foreground,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}