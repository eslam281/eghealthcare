
import 'package:dartz/dartz.dart';
import 'package:eghealthcare/core/usecase/usecase.dart';

import '../../../../../injection_container.dart';
import '../repository/dashboard_repository.dart';

class ChatbotUseCase extends UseCase<Either, String?>{
  @override
  Future<Either> call({params}) async{
    return await sl<DocDashboardRepository>().getChatbot(params!);
  }

}