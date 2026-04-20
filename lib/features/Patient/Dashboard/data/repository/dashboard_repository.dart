
import 'package:dartz/dartz.dart';

import '../../../../../injection_container.dart';
import '../../domain/repository/dashboard_repository.dart';
import '../source/DashboardApi.dart';

class PDashboardRepositoryImpl extends PDashboardRepository {
  @override
  Future<Either> getDoctors() async{
    return await sl<PDashboardApi>().getDoctors();
  }

  @override
  Future<Either> getDoctor(String id) async{
    return await sl<PDashboardApi>().getDoctor(id);
  }

  @override
  Future<Either> getUser() async{
    return await sl<PDashboardApi>().getUser();
  }
  @override
  Future<Either> getAppointment()async{
    return await sl<PDashboardApi>().getAppointment();
  }

}