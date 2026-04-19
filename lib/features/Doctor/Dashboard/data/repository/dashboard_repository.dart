
import 'package:dartz/dartz.dart';

import '../../../../../injection_container.dart';

import '../../domain/repository/dashboard_repository.dart';
import '../source/DashboardApi.dart';

class DocDashboardRepositoryImpl extends DocDashboardRepository {
  @override
  Future<Either> getPatients() async{
    return await sl<DocDashboardApi>().getPatients();
  }

  @override
  Future<Either> getPatient(String id) async{
    return await sl<DocDashboardApi>().getPatient(id);
  }

  @override
  Future<Either> getUser() async{
    return await sl<DocDashboardApi>().getUser();
  }

  @override
  Future<Either> getAppointment(){
    return sl<DocDashboardApi>().getAppointment();
  }

}