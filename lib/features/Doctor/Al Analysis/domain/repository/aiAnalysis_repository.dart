
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

abstract class AiAnalysisRepository {
  Future<Either> analyseXray( XFile? image);
}