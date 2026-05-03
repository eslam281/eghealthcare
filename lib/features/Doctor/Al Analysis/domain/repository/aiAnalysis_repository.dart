
import 'package:dartz/dartz.dart';

abstract class AiAnalysisRepository {
  Future<Either> analyseXray();
}