
import 'package:dartz/dartz.dart';
import 'package:eghealthcare/core/usecase/usecase.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../injection_container.dart';
import '../repository/aiAnalysis_repository.dart';

class AiAnalysisUseCase extends UseCase<Either, XFile?>{
  @override
  Future<Either> call({params}) async{
    return await sl<AiAnalysisRepository>().analyseXray(params);
  }

}