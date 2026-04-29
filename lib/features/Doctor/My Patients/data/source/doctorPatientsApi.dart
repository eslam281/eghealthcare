import 'package:dartz/dartz.dart';
import 'package:eghealthcare/core/shared/model/patient_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../../core/constants/links.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/network_call_handler.dart';
import '../../../../../injection_container.dart';
import '../../domain/entities/patient_entity.dart';
import '../models/doctorPatientModel.dart';

abstract class DoctorPatientsApi {
  Future<Either> getPatients();
}

class DoctorPatientsApiImpl implements DoctorPatientsApi{

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

}