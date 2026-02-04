import '../services/role_service.dart';

class AppStartDecider {
  final RoleService roleService;

  AppStartDecider(this.roleService);

  // Future<String> decideRoute() async {
  //   final role = await roleService.getCurrentRole();
  //
  //   if (role == UserRole.doctor) {
  //     return Routes.doctorDashboard;
  //   } else if (role == UserRole.patient) {
  //     return Routes.patientHome;
  //   } else {
  //     return Routes.login;
  //   }
  // }
}
