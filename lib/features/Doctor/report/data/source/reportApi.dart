import 'package:dartz/dartz.dart';

import '../../../../../core/constants/links.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/network_call_handler.dart';
import '../../../../../injection_container.dart';

abstract class ReportApi{
  Future<Either> makeReport( Map<String,dynamic> body);
  Future<Either> makeTemplate( Map<String,dynamic> body);
  Future<Either> chatRAG(Map<String,dynamic> body);
}

class ReportApiImpl implements ReportApi{
  
  @override
  Future<Either<dynamic, dynamic>> makeReport(Map<String,dynamic> body) async{
    final response = await sl<NetworkCallHandler>().call(
            ()=> sl<ApiClient>().post(AppLinks.medicalHistory,
            body:body ));
    print("===========================response : ${response.toString()}");

    return response.fold(
          (failure) => Left(failure),
          (data) {

        return Right(data);
      },
    );
  }

  @override
  Future<Either<dynamic, dynamic>> chatRAG( Map<String, dynamic> body) async{
    final response = await sl<NetworkCallHandler>().call(
            ()=> sl<ApiClient>().post("${AppLinks.medicalHistory}/chat",
            body:body ));
    print("===========================response : ${response.toString()}");

    return response.fold(
          (failure) => Left(failure),
          (data) {

        return Right(data);
      },
    );
  }

  @override
  Future<Either<dynamic, dynamic>> makeTemplate( Map<String, dynamic> body)async {
    final response = await sl<NetworkCallHandler>().call(
            ()=> sl<ApiClient>().post("${AppLinks.medicalHistory}/generate-template",
            body:body ));
    print("===========================response : ${response.toString()}");

    return response.fold(
          (failure) => Left(failure),
          (data) {

        return Right(data);
      },
    );
  }

}