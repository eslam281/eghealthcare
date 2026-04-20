
import 'package:dartz/dartz.dart';
import 'package:eghealthcare/core/constants/links.dart';
import 'package:eghealthcare/core/services/role_service.dart';
import 'package:eghealthcare/injection_container.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/network_call_handler.dart';
import '../../../../../core/shared/model/appointment_model.dart';
import '../../../../../core/shared/model/doctor_model.dart';
import '../../domain/entities/appointment_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../models/appointment_mapper.dart';
import '../models/doctor_model.dart';

abstract class DocDashboardApi{
  Future <Either> getPatients();
  Future <Either> getPatient(String id);
  Future <Either> getAppointment();

  Future<Either> getUser();

}

class DocDashboardApiImpl implements DocDashboardApi{
  @override

  @override
  Future<Either<dynamic, dynamic>> getPatients() async{
    final String id = await sl<FlutterSecureStorage>().read(key: 'uid')??'';
    return await sl<NetworkCallHandler>().call(()=> sl<ApiClient>().get(
        "${AppLinks.appointment}/$id",));
  }

  @override
  Future<Either<dynamic, dynamic>> getPatient(String id) async{
    return await sl<NetworkCallHandler>().call(()=> sl<ApiClient>().get(
        "${AppLinks.patient}/$id",));
  }

  @override
  Future<Either<Failure,UserEntity>> getUser() async{
    String? id = await sl<FlutterSecureStorage>().read(key: 'uid');
    final response = await sl<NetworkCallHandler>().call(
            ()=> sl<ApiClient>().get("${AppLinks.doctor}/$id"));
    print("===========================response : ${response.toString()}");

    return response.fold(
          (failure) => Left(failure),
          (data) {
        final DoctorModel userModels =DoctorModel.fromJson(data);
        final UserEntity user = userModels.toUserEntity();
        return Right(user);
      },
    );
  }

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getAppointment() async{
    String? id = await sl<FlutterSecureStorage>().read(key: 'uid');
    UserRole? role = await sl<RoleService>().getCurrentRole();

    final response = await sl<NetworkCallHandler>().call(
            () => sl<ApiClient>().get(AppLinks.appointment,
                queryParameters: {'doctorID': id}
            ));
    print("===========================response : ${response.toString()}");

    return response.fold(
          (failure) => Left(failure),
          (data) {
        final List<AppointmentModel> appointmentModels =
        (data as List).map((e) => AppointmentModel.fromJson(e)).toList();

        final List<AppointmentEntity> user =
        appointmentModels.map((e) => e.toAppointmentEntity()).toList();

        return Right(user);
      },
    );
  }
}