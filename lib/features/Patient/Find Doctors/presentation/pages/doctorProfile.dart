import 'package:eghealthcare/core/themes/app_colors_light.dart';
import 'package:eghealthcare/core/themes/components_style.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../domain/entities/doctor_entity.dart';
import '../widgets/bookAppointmentDialog.dart';

class DoctorProfile extends StatelessWidget {
  final DoctorEntity doctor;

  const DoctorProfile({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            _buildHeaderCard(context),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 900) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _buildAboutSection()),
                      const SizedBox(width: 24),
                      Expanded(flex: 1, child: _buildAvailabilitySection()),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      _buildAboutSection(),
                      const SizedBox(height: 24),
                      _buildAvailabilitySection(),
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
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppStyle.borderRadius,
            border: Border.all(color: AppColorsLight.border.withAlpha(150)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(8),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: isMobile ? 30 : 40,
                    backgroundColor: AppColorsLight.primary.withAlpha(25),
                    child: Text(
                      doctor.name.isNotEmpty ? doctor.name[0].toUpperCase() : 'D',
                      style: TextStyle(
                        fontSize: isMobile ? 24 : 32,
                        fontWeight: FontWeight.bold,
                        color: AppColorsLight.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor.name,
                          style: TextStyle(
                            fontSize: isMobile ? 20 : 24,
                            fontWeight: FontWeight.bold,
                            color: AppColorsLight.foreground,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 12,
                          runSpacing: 8,
                          children: [
                            _buildTag(LucideIcons.briefcase, '${doctor.experience ?? 'N/A'} experience'),
                            _buildTag(LucideIcons.star, '0 reviews', color: AppColorsLight.warning),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (!isMobile) ...[
                    const SizedBox(width: 24),
                    _buildBookButton(context),
                  ],
                ],
              ),
              if (isMobile) ...[
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: _buildBookButton(context),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildBookButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => BookAppointmentDialog(
            doctor: doctor,
          ),
        );
      },
      icon: const Icon(LucideIcons.calendar, size: 18),
      label: const Text('Book Appointment'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColorsLight.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildTag(IconData icon, String label, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: (color ?? AppColorsLight.mutedForeground).withAlpha(20),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color ?? AppColorsLight.mutedForeground),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color ?? AppColorsLight.mutedForeground,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppStyle.borderRadius,
        border: Border.all(color: AppColorsLight.border.withAlpha(155)),
      ),
      child: Column(
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
              Expanded(child: _buildInfoBox('Specialty', doctor.specialty)),
              const SizedBox(width: 16),
              Expanded(child: _buildInfoBox('Experience', doctor.experience ?? 'N/A')),
            ],
          ),
          if (doctor.bio != null && doctor.bio!.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(
              doctor.bio!,
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

  Widget _buildAvailabilitySection() {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
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
          ...days.map((day) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  day,
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
                  child: const Text(
                    'Unavailable',
                    style: TextStyle(
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
