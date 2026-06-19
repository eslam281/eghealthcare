import 'package:dartz/dartz.dart';

abstract class ReportRepository {
  Future<Either> makeReport( Map<String,dynamic> body);
  Future<Either> makeTemplate( Map<String,dynamic> body);
  Future<Either> chatRAG( Map<String,dynamic> body);
}