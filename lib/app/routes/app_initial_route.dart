import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/services/role_service.dart';
import '../../injection_container.dart';
import '../splash/splash_cubit.dart';

class AppStartDecider {
  final RoleService roleService;

  AppStartDecider(this.roleService);

  Future<SplashState> decideRoute() async {
    final role = await roleService.getCurrentRole();
    final uid = await sl<FlutterSecureStorage>().read(key: 'uid');

    if (uid == null) {
      return GoToLogin();
    } else {
      if (role == UserRole.doctor) {
        return GoToDoctorHome();
      } else if (role == UserRole.patient) {
        return GoToPatientHome();
      }
    }
    return GoToLogin();
  }
}
