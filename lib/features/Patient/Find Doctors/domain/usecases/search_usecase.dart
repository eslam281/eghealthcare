
import 'package:dartz/dartz.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../../../injection_container.dart';
import '../repository/findDoctor_repository.dart';

class SearchUseCase implements UseCase<Either,String?>{
  @override
  Future<Either<dynamic, dynamic>> call({String? params}) async{
    return await sl<FindDoctorRepository>().search(params!);
  }

}