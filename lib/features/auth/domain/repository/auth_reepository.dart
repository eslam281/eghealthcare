import 'package:dartz/dartz.dart';

import '../../data/models/create_user_req.dart';
import '../../data/models/signin_user_req.dart';

abstract class AuthRepository{
  Future <Either> signup(CreateUserReq createuserReq);
  Future<Either> signin(SignInUserReq signInUserReq);
  Future<Either> getUser();
}