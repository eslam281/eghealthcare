
import 'package:dartz/dartz.dart';
import 'package:eghealthcare/core/constants/links.dart';
import 'package:eghealthcare/injection_container.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/network_call_handler.dart';
import '../../domain/entities/user_entity.dart';
import '../models/doctor_model.dart';

abstract class DocDashboardApi{
  Future <Either> getPatients();
  Future <Either> getPatient(String id);

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
        final UserEntity user = userModels.doctorEntity();
        return Right(user);
      },
    );
  }
}