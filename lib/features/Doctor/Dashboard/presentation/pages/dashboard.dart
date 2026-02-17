import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/shared/drawer.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/Drawer_body.dart';

class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc()..add(LoadDashboardRequested()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Doctor Dashboard")),
        drawer: const AppDrawer(body: DrawerBody(),),
        floatingActionButton: FloatingActionButton(onPressed: () {
          // context.read<AuthBloc>().add(
          //   GetUserRequested(),
          // );
          // context.read<AuthBloc>().add(
          //   LogoutRequested(),
          // );
        }, shape: const CircleBorder(),
          child: const Icon(Icons.support_agent, color: Colors.white,),
        ),
        body: const Center(child: Text("Doctor Dashboard")),
      ),
    );
  }
}
