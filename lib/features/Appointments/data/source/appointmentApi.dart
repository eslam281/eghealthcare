import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/constants/links.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/network_call_handler.dart';
import '../../../../core/services/role_service.dart';
import '../../../../core/shared/model/appointment_model.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/appointment_entity.dart';
import '../models/appointment_mapper.dart';

abstract class AppointmentApi {
  Future<Either> getAppointment();
  Future<Either> getAppointmentById(int id);
  Future<Either> deleteAppointment(int id);
}
class AppointmentApiImpl implements AppointmentApi {

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getAppointment() async{
    String? id = await sl<FlutterSecureStorage>().read(key: 'uid');
    UserRole? role = await sl<RoleService>().getCurrentRole();

    final response = await sl<NetworkCallHandler>().call(
            () => sl<ApiClient>().get(AppLinks.appointment,
            queryParameters:role==UserRole.doctor?
            {'doctorID': id} : {'patientID': id}
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

  @override
  Future<Either> getAppointmentById(int id) async{
    final response = await sl<NetworkCallHandler>().call(
            () => sl<ApiClient>().get("${AppLinks.appointment}/$id",));
    print("===========================response : ${response.toString()}");

    return response.fold(
          (failure) => Left(failure),
          (data) {
        final AppointmentModel appointmentModels = AppointmentModel.fromJson(data);
        final AppointmentEntity user = appointmentModels.toAppointmentEntity();
        return Right(user);
      },
    );
  }

  @override
  Future<Either<dynamic, dynamic>> deleteAppointment(int id)async {
    final response = await sl<NetworkCallHandler>().call(
            () => sl<ApiClient>().delete("${AppLinks.appointment}/$id",));
    print("===========================response : ${response.toString()}");

    return response.fold(
          (failure) => Left(failure),
          (data) {return Right(data);},
    );
  }

}