import 'package:flutter/material.dart';

import '../../../../../core/themes/app_gradients.dart';
import '../../../../auth/domain/entities/user.dart';

class DashboardHeader extends StatelessWidget {
  final UserEntity user;

  const DashboardHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient:AppGradients.hero  ,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Doctor Dashboard",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Manage your appointments, patients, and access Al-powered medical analysis tools.",
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
