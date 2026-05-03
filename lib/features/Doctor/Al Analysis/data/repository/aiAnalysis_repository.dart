
import 'package:dartz/dartz.dart';
import 'package:eghealthcare/injection_container.dart';

import '../../domain/repository/aiAnalysis_repository.dart';
import '../source/aiAnalysis_api.dart';

class AiAnalysisRepositoryImpl implements AiAnalysisRepository{
  @override
  Future<Either<dynamic, dynamic>> analyseXray() async{
    return await sl<AiAnalysisApi>().analyseXray();
  }

}