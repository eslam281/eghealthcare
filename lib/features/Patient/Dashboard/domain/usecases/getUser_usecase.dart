
import 'package:dartz/dartz.dart';
import 'package:eghealthcare/core/usecase/usecase.dart';

import '../../../../../injection_container.dart';
import '../repository/dashboard_repository.dart';

class GetUserUseCase extends UseCase<Either, int?>{
  @override
  Future<Either> call({params}) async{
    return await sl<DashboardRepository>().getUser();

  }

}