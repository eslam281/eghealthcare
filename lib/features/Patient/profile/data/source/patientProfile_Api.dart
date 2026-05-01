
import 'package:dartz/dartz.dart';

import '../../../../../core/constants/links.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/network_call_handler.dart';
import '../../../../../core/shared/model/patient_model.dart';
import '../../../../../injection_container.dart';
import '../../domain/entities/patientProfile_entities.dart';
import '../models/patientProfile_model.dart';

abstract class PatientProfileApi {
  Future<Either> getPatientProfile(String id);
}

class PatientProfileApiImpl implements PatientProfileApi{

  @override
  Future<Either<dynamic, dynamic>> getPatientProfile(String id) async{
    final response = await sl<NetworkCallHandler>().call(
            ()=> sl<ApiClient>().get("${AppLinks.patient}/$id"));
    print("===========================response : ${response.toString()}");

    return response.fold(
          (failure) => Left(failure),
          (data) {
        final PatientModel patientModel =PatientModel.fromJson(data);
        final PatientProfileEntities patientProfile = patientModel.toPatientProfileEntities();
        return Right(patientProfile);
      },
    );
  }

}