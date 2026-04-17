
import 'package:dartz/dartz.dart';

import '../../../../../injection_container.dart';
import '../../domain/repository/dashboard_repository.dart';
import '../source/DashboardApi.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  @override
  Future<Either> getDoctors() async{
    return await sl<DashboardApi>().getDoctors();
  }

  @override
  Future<Either> getDoctor(String id) async{
    return await sl<DashboardApi>().getDoctor(id);
  }

  @override
  Future<Either> getUser() async{
    return await sl<DashboardApi>().getUser();
  }

}