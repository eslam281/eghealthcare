
import 'package:dartz/dartz.dart';
import 'package:eghealthcare/core/shared/model/doctor_model.dart';
import 'package:eghealthcare/features/Doctor/profile/data/models/doctorProfile_model.dart';

import '../../../../../core/constants/links.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/network_call_handler.dart';
import '../../../../../injection_container.dart';
import '../../domain/entities/doctor_entity.dart';

abstract class DoctorProfileApi{
  Future<Either> getDoctorProfile(String id);
}
class DoctorProfileApiImpl implements DoctorProfileApi{
  @override
  Future<Either<dynamic, dynamic>> getDoctorProfile(String id) async{
    final response = await sl<NetworkCallHandler>().call(
            ()=> sl<ApiClient>().get("${AppLinks.doctor}/$id"));
    print("===========================response : ${response.toString()}");

    return response.fold(
          (failure) => Left(failure),
          (data) {
        final DoctorModel doctorModel =DoctorModel.fromJson(data);
        final DoctorEntity patientProfile = doctorModel.toDoctorProfileEntity();
        return Right(patientProfile);
      },
    );
  }

}