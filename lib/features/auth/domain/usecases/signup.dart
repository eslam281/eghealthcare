
import 'package:dartz/dartz.dart';
import 'package:eghealthcare/core/usecase/usecase.dart';

import '../../../../injection_container.dart';
import '../../data/models/create_user_req.dart';
import '../repository/auth_reepository.dart';

class SingUpUseCase implements UseCase<Either,CreateUserReq>{
  @override
  Future<Either> call({CreateUserReq? params}) async{
    return await sl<AuthRepository>().signup(params!);

  }

}