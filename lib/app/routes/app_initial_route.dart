import '../../core/services/role_service.dart';
import '../../core/constants/routes.dart';

class AppStartDecider {
  final RoleService roleService;

  AppStartDecider(this.roleService);

  Future<String> decideRoute() async {
    final role = await roleService.getCurrentRole();

    if (role == UserRole.doctor) {
      return Routes.doctorDashboard;
    } else if (role == UserRole.patient) {
      return Routes.patientDashboard;
    } else {
      return Routes.login;
    }
  }
}
