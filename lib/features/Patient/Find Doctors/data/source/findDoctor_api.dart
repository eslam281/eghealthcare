import 'package:dartz/dartz.dart';

import '../../../../../core/constants/links.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/network_call_handler.dart';
import '../../../../../core/shared/model/doctor_model.dart';
import '../../../../../injection_container.dart';
import '../../domain/entities/doctor_entity.dart';
import '../models/doctor_model.dart';

abstract class FindDoctorApi {
  Future <Either> getDoctors();
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
}