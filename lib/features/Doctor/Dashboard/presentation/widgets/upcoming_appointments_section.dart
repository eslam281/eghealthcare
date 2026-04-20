
import 'package:eghealthcare/core/shared/widget/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/routes.dart';
import '../../../../../core/themes/app_colors_light.dart';
import '../../domain/entities/appointment_entity.dart';
import '../bloc/dashboard_bloc.dart';

class UpcomingAppointmentsSection extends StatelessWidget {
  final List<AppointmentEntity> appointments;

  const UpcomingAppointmentsSection({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
  builder: (context, state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Upcoming Appointments",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.myAppointments);
              },
              child: Row(
                children: [
                  Text(
                    "View All",
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 15,
                      color: Theme.of(context).colorScheme.onSurfaceVariant
                  ),
                ],
              ),
            ),
          ],
        ),

        ...appointments.map((a) => AppointmentCard(
            appointment: a,
            onPressed: () {
              context.read<DashboardBloc>().add(DeleteAppointments(a.id));
            }
        )),
      ],
    );
  },
);
  }
}
class AppointmentCard extends StatelessWidget {
  final AppointmentEntity appointment;
  final void Function() onPressed;

  const AppointmentCard({super.key, required this.appointment, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Top Row (Doctor + Status)
            Row(
              children: [
                AvatarImage(imageUrl: appointment.avatar, radius: 50),
                const SizedBox(width: 12),

                /// Name + Type
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.patientName,
                        style: theme.textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        appointment.type,
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),

                /// Status Badge
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColorsLight.info.withAlpha(20),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    appointment.status,
                    style: theme.textTheme.labelSmall!.copyWith(
                      color: AppColorsLight.info,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// 🔹 Date & Time
            Row(
              children: [
                Icon(Icons.calendar_today_outlined,
                    size: 18, color: colors.onSurfaceVariant),
                const SizedBox(width: 6),
                Text(appointment.date, style: theme.textTheme.bodyMedium),
                const SizedBox(width: 16),
                Icon(Icons.access_time,
                    size: 18, color: colors.onSurfaceVariant),
                const SizedBox(width: 6),
                Text(appointment.time, style: theme.textTheme.bodyMedium),
              ],
            ),

            const SizedBox(height: 12),
            Divider(color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(50),),


            /// 🔹 Cancel Button
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: onPressed,
                icon: Icon(Icons.close, color: colors.error),
                label: Text(
                  "Cancel",
                  style: theme.textTheme.labelLarge!
                      .copyWith(color: colors.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}