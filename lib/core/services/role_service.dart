
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum UserRole { doctor, patient }

abstract class RoleService {
  Future<UserRole?> getCurrentRole();
  Future<void> saveRole(UserRole role);
  Future<void> clearRole();
}

class RoleServiceImpl implements RoleService {
  final FlutterSecureStorage storage;

  RoleServiceImpl(this.storage);

  @override
  Future<UserRole?> getCurrentRole() async {
    final role = await storage.read(key: 'user_role');

    if (role == 'doctor') return UserRole.doctor;
    if (role == 'patient') return UserRole.patient;
    return null;
  }

  @override
  Future<void> saveRole(UserRole role) async {
    await storage.write(
      key: 'user_role',
      value: role.name,
    );
  }

  @override
  Future<void> clearRole() async {
    await storage.delete(key: 'user_role');
  }
}
