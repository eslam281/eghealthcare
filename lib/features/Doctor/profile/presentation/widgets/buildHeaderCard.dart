import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../core/shared/widget/avatar.dart';
import '../../../../../core/themes/app_colors_light.dart';
import '../../../../../core/themes/components_style.dart';
import '../../../../Patient/Find Doctors/domain/entities/doctor_entity.dart'as find_entity;
import '../../../../Patient/Find Doctors/presentation/widgets/bookAppointmentDialog.dart';
import '../../domain/entities/doctor_entity.dart';
import '../bloc/doctor_profile_bloc.dart';

Widget buildHeaderCard(BuildContext context) {
  return BlocBuilder<DoctorProfileBloc,DoctorProfileState>(
    builder: (context, state) {
      if (state is DoctorProfileLoaded){
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
                  AvatarImage(
                      imageUrl:state.doctorEntity.avatar, radius: 30, name: state.doctorEntity.name, onTap: () {}),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.doctorEntity.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColorsLight.foreground,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 12,
                          runSpacing: 8,
                          children: [
                            _buildTag(LucideIcons.briefcase,
                                '${state.doctorEntity.experience ?? 'N/A'} experience'),
                            _buildTag(LucideIcons.star, '0 reviews',
                                color: AppColorsLight.warning),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ...[
                    const SizedBox(width: 24),
                    _buildBookButton(context,state.doctorEntity),
                  ],
                ],
              ),
              ...[
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: _buildBookButton(context,state.doctorEntity),
                ),
              ],
            ],
          ),
        );
      }
      return const SizedBox();
    },
  );
}
Widget _buildBookButton(BuildContext context,DoctorEntity doctorEntity) {
  return ElevatedButton.icon(
    onPressed: () {
      showDialog(
        context: context,
        builder: (context) => BookAppointmentDialog(
          doctor: find_entity.DoctorEntity(name: doctorEntity.name,
              specialty: doctorEntity.name, id: doctorEntity.id),
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