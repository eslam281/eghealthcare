import '../../core/services/role_service.dart';
import '../splash/splash_cubit.dart';

class AppStartDecider {
  final RoleService roleService;

  AppStartDecider(this.roleService);

  Future<SplashState> decideRoute() async {
    final role = await roleService.getCurrentRole();

    if (role == UserRole.doctor) {
      return GoToDoctorHome();
    } else if (role == UserRole.patient) {
      return GoToPatientHome();
    } else {
      return GoToLogin();
    }
  }
}
