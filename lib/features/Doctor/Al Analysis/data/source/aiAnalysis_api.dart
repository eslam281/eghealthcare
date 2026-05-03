
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/constants/links.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/network_call_handler.dart';
import '../../../../../injection_container.dart';

abstract class AiAnalysisApi {
  Future<Either> analyseXray(XFile? image);
}
class AiAnalysisApiImpl implements AiAnalysisApi{
  @override
  Future<Either<dynamic, dynamic>> analyseXray(XFile? image) async{
    final response = await sl<NetworkCallHandler>().call(
            ()=> sl<ApiClient>().post("${AppLinks.aiAnalysis}/xray",
              headers:{'Content-Type': 'application/x-www-form-urlencoded',} ,
              body: {"file":image}
            ));
    print("===========================response : ${response.toString()}");

    return response.fold((failure) => Left(failure), (r) => r,);
  }
}