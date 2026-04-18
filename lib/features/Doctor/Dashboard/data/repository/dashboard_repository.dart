
import 'package:dartz/dartz.dart';

import '../../../../../injection_container.dart';

import '../../domain/repository/dashboard_repository.dart';
import '../source/DashboardApi.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  @override
  Future<Either> getPatients() async{
    return await sl<DashboardApi>().getPatients();
  }

  @override
  Future<Either> getPatient(String id) async{
    return await sl<DashboardApi>().getPatient(id);
  }

  @override
  Future<Either> getUser() async{
    return await sl<DashboardApi>().getUser();
  }

}