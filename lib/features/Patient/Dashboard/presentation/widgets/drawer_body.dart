
import 'package:flutter/material.dart';

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
              Navigator.of(context).pushNamed( Routes.doctorDashboard);
            },

          ),
          DrawerItem(
            icon: Icons.search,
            title: "Find Doctors",
            onTap: () {
              Navigator.of(context).pushNamed( Routes.findDoctor);
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
            icon: Icons.description_outlined,
            title: "Diagnosis History",
            onTap: () {
              Navigator.of(context).pushNamed( Routes.diagnosisHistory);
            },
          ),
          DrawerItem(
            icon: Icons.chat_bubble_outline,
            title: "Messages",
            onTap: () {
              Navigator.of(context).pushNamed( Routes.chatPage);
            },
          ),
        ],
      ),
    );
  }
}
