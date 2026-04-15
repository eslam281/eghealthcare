
import 'package:dartz/dartz.dart';
import 'package:eghealthcare/core/constants/links.dart';
import 'package:eghealthcare/injection_container.dart';

import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/network_call_handler.dart';

abstract class DoctorApi{
  Future <Either> getDoctors();
  Future <Either> getDoctor(String id);

}

class DoctorApiImpl implements DoctorApi{
  @override
  Future<Either> getDoctors() async {
    return await sl<NetworkCallHandler>().call(await sl<ApiClientImpl>().get(AppLinks.doctor));
  }

  @override
  Future<Either<dynamic, dynamic>> getDoctor(String id) {
    // TODO: implement getDoctor
    throw UnimplementedError();
  }
}