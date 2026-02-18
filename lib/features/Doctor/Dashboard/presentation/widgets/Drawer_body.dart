
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../core/constants/routes.dart';
import '../../../../../core/shared/drawer.dart';

class DrawerBody extends StatelessWidget {
  const DrawerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          DrawerItem(
            icon: Icons.home_outlined,
            title: "Dashboard",
            isActive: true,
            onTap: () {
              Navigator.of(context).pushNamed( Routes.patientDashboard);
            },

          ),
          DrawerItem(
            icon: Icons.calendar_today_outlined,
            title: "Appointments",
            onTap: () {
              Navigator.of(context).pushNamed( Routes.myAppointments);
            },
          ),
          DrawerItem(
            icon: LucideIcons.users,
            title: "My Patients",
            onTap: () {
              Navigator.of(context).pushNamed( Routes.myPatients);
            },
          ),
          DrawerItem(
            icon: Icons.chat_bubble_outline,
            title: "Messages",
            onTap: () {
              Navigator.of(context).pushNamed( Routes.chatPage);
            },
          ),
          DrawerItem(
            icon: Icons.support_agent_rounded,
            title: "Al Analysis",
            onTap: () {
              // Navigator.of(context).pushNamed( Routes.chatPage);
            },
          ),
        ],
      ),
    );
  }
}
