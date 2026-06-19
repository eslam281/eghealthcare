
import 'package:dartz/dartz.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../../../injection_container.dart';
import '../repository/report_repository.dart';

class ChatRAGUseCase extends UseCase<Either, Map<String,dynamic>?>{
  @override
  Future<Either<dynamic, dynamic>> call({Map<String,dynamic>? params}) async{
    return await sl<ReportRepository>().chatRAG(params!);
  }
}