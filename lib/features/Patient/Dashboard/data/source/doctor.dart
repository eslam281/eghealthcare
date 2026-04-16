
import 'package:dartz/dartz.dart';
import 'package:eghealthcare/core/constants/links.dart';
import 'package:eghealthcare/injection_container.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/network_call_handler.dart';
import '../../domain/entities/doctor_entity.dart';
import '../models/doctor_model.dart';

abstract class DoctorApi{
  Future <Either> getDoctors();
  Future <Either> getDoctor(String id);

}

class DoctorApiImpl implements DoctorApi{
  @override
  Future<Either<Failure, dynamic>> getDoctors() async {
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
    return await sl<NetworkCallHandler>().call(await sl<ApiClient>().get(
        AppLinks.doctor,
        queryParameters: {
          'id': id
        }
    ));
  }
}