import 'package:dartz/dartz.dart';
import 'package:eghealthcare/core/shared/model/appointment_model.dart';

import '../../../../../core/constants/links.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/network_call_handler.dart';
import '../../../../../core/shared/model/doctor_model.dart';
import '../../../../../injection_container.dart';
import '../../domain/entities/appointment_entity.dart';
import '../../domain/entities/doctor_entity.dart';
import '../models/doctor_model.dart';
import '../models/appointment_mapper.dart';

abstract class FindDoctorApi {
  Future <Either> getDoctors();
  Future <Either> search(String query);
  Future <Either> createAppointment(Map<String,dynamic> appointmentCreate);
}

class FindDoctorApiImpl implements FindDoctorApi{
  @override
  Future<Either<dynamic, dynamic>> getDoctors() async {
    final response = await sl<NetworkCallHandler>().call(
            ()=> sl<ApiClient>().get(AppLinks.doctor));
    print("===========================response : ${response.toString()}");
    return response.fold(
          (failure) => Left(failure),
          (data) {
        final List<DoctorModel> doctorModels =
        (data as List).map((e) => DoctorModel.fromJson(e)).toList();

        final List<DoctorEntity> doctors =
        doctorModels.map((e) => e.doctorEntity()).toList();

        return Right(doctors);
      },
    );
  }

  @override
  Future<Either<dynamic, dynamic>> createAppointment(Map<String,dynamic> appointmentCreate) async{
    final response = await sl<NetworkCallHandler>().call(
            ()=> sl<ApiClient>().post(AppLinks.appointment,
              body: appointmentCreate
            ));
    print("===========================response : ${response.toString()}");
    return response.fold(
          (failure) => Left(failure),
          (data) {
        final AppointmentModel appointmentModel = AppointmentModel.fromJson(data);

        final AppointmentEntity appointmentEntity= appointmentModel.toAppointmentEntity();

        return Right(appointmentEntity);
      },
    );
  }

  @override
  Future<Either<dynamic, dynamic>> search(String query) async {

    final response = await sl<NetworkCallHandler>().call(
            ()=> sl<ApiClient>().get(AppLinks.doctor,
            queryParameters:{"search":query} ));
    print("===========================response : ${response.toString()}");
    return response.fold(
          (failure) => Left(failure),
          (data) {
        final List<DoctorModel> doctorModels =
        (data as List).map((e) => DoctorModel.fromJson(e)).toList();

        final List<DoctorEntity> doctors =
        doctorModels.map((e) => e.doctorEntity()).toList();

        return Right(doctors);
      },
    );
  }
}