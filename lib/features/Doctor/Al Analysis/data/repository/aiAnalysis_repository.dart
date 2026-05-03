
import 'package:dartz/dartz.dart';
import 'package:eghealthcare/injection_container.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/repository/aiAnalysis_repository.dart';
import '../source/aiAnalysis_api.dart';

class AiAnalysisRepositoryImpl implements AiAnalysisRepository{
  @override
  Future<Either<dynamic, dynamic>> analyseXray( XFile? image) async{
    return await sl<AiAnalysisApi>().analyseXray(image);
  }

}