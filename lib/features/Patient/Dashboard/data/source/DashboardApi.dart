
import 'package:dartz/dartz.dart';
import 'package:eghealthcare/core/constants/links.dart';
import 'package:eghealthcare/features/Patient/Dashboard/data/models/patient_model.dart';
import 'package:eghealthcare/injection_container.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/network_call_handler.dart';
import '../../domain/entities/doctor_entity.dart';
import '../../domain/entities/user_entity.dart' show UserEntity;
import '../models/doctor_model.dart';

abstract class PDashboardApi{
  Future <Either> getDoctors();
  Future <Either> getDoctor(String id);

  Future<Either> getUser();

}

class PDashboardApiImpl implements PDashboardApi{
  @override
  Future<Either<Failure, List<DoctorEntity>>> getDoctors() async {
    print("===========================getDoctors");
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
  Future<Either<dynamic, dynamic>> getDoctor(String id) async{
    return await sl<NetworkCallHandler>().call(()=> sl<ApiClient>().get(
        AppLinks.doctor,
        queryParameters: {
          'doctorID': id
        }
    ));
  }

  @override
  Future<Either<Failure,UserEntity>> getUser() async{
    String? id = await sl<FlutterSecureStorage>().read(key: 'uid');
    final response = await sl<NetworkCallHandler>().call(
            ()=> sl<ApiClient>().get("${AppLinks.patient}/$id"));
    print("===========================response : ${response.toString()}");

    return response.fold(
          (failure) => Left(failure),
          (data) {
        final PatientModel userModels =PatientModel.fromJson(data);
        final UserEntity user = userModels.toPatientEntity();
        return Right(user);
      },
    );
  }
}