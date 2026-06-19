import 'package:dartz/dartz.dart';

import '../../../../../injection_container.dart';
import '../../domain/repository/report_repository.dart';
import '../source/reportApi.dart';

 class ReportRepositoryImpl implements ReportRepository {

  @override
  Future<Either> makeReport( Map<String,dynamic> body)async {
    return await sl<ReportApi>().makeReport( body);
  }

  @override
  Future<Either> makeTemplate(Map<String,dynamic> body) async{
    return await sl<ReportApi>().makeTemplate( body);
  }

  @override
  Future<Either> chatRAG( Map<String,dynamic> body)async{
    return await sl<ReportApi>().chatRAG(body);
  }
}