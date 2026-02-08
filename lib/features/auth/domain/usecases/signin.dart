
import 'package:dartz/dartz.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';
import '../../data/models/signin_user_req.dart';
import '../repository/auth_reepository.dart';

class SignInUseCase implements UseCase<Either,SignInUserReq>{
  @override
  Future<Either> call({SignInUserReq? params}) async {
    return await sl<AuthRepository>().signin(params!);
  }
}