
import 'package:dartz/dartz.dart';
import 'package:eghealthcare/core/constants/links.dart';
import 'package:eghealthcare/injection_container.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/network_call_handler.dart';
import '../../../../../core/services/fcm_service.dart';
import '../../../../../core/shared/model/appointment_model.dart';
import '../../../../../core/shared/model/doctor_model.dart';
import '../../../../../core/shared/model/patient_model.dart';
import '../../domain/entities/appointment_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/patient_entity.dart';
import '../models/appointment_mapper.dart';
import '../models/doctor_model.dart';
import '../models/doctorPatientModel.dart';

abstract class DocDashboardApi{
  Future <Either> getPatients();
  Future <Either> getPatient(String id);
  Future <Either> getAppointment();
  Future<Either> getUser();
  Future <Either> getChatbot(String message);

}

class DocDashboardApiImpl implements DocDashboardApi{
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  @override
  Future<Either> getPatients() async{
    String? id = await sl<FlutterSecureStorage>().read(key: 'uid');
    final response = await sl<NetworkCallHandler>().call(
            ()=> sl<ApiClient>().get("${AppLinks.appointment}/doctors/$id/patients"));
    print("===========================response : ${response.toString()}");

    return response.fold(
          (failure) => Left(failure),
          (data) {

        final List<PatientModel> patientModel =
        (data as List).map((e) => PatientModel.fromJson(e)).toList();

        final List<PatientEntity> patientEntity =
        patientModel.map((e) => e.toPatientEntity()).toList();

        return Right(patientEntity);
      },
    );
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

    final  token = await sl<FCMService>().getToken(id!);
    print("=============================== token : $token");
    final  newToken = await sl<FCMService>().onRefreshToken(id);
    print("=============================== new token : $newToken");

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

  @override
  Future<Either<dynamic, dynamic>> getChatbot(String message) async{
    final response = await sl<NetworkCallHandler>().call(
            ()=> sl<ApiClient>().post(AppLinks.chatbot, body: {"message":message}));

    print("===========================response : ${response.toString()}");
    return response.fold(
          (failure) => Left(failure),
          (r) => Right(r),
    );
  }
}