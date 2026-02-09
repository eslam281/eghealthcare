import 'package:dartz/dartz.dart';

import '../../../../injection_container.dart';
import '../../domain/repository/auth_reepository.dart';
import '../models/create_user_req.dart';
import '../models/signin_user_req.dart';
import '../source/auth_firebase_service.dart';


class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<Either> signin(SignInUserReq signInUserReq) async {
    return await sl<AuthFirebaseService>().signin(signInUserReq);
  }
  @override
  Future<Either> singInWithGoogle()async {
    return await sl<AuthFirebaseService>().singInWithGoogle();
  }

  @override
  Future<Either> signup(CreateUserReq createuserReq)async {
    return await sl<AuthFirebaseService>().signup(createuserReq);
  }

  @override
  Future<Either> getUser() async{
    return await sl<AuthFirebaseService>().getUser();
  }

  @override
  Future<Either<dynamic, dynamic>> signOut() async {
    return await sl<AuthFirebaseService>().signOut();
  }

}