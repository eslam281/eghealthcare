import 'package:dartz/dartz.dart';
import 'package:eghealthcare/core/services/role_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/constants/links.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/network_call_handler.dart';
import '../../../../injection_container.dart';
import '../models/create_user_req.dart';
import '../models/signin_user_req.dart';

abstract class AuthFirebaseService{
  Future<Either> signup(CreateUserReq createuserReq);
  Future<Either> signin(SignInUserReq signInUserReq);
  Future<Either> singInWithGoogle();
  Future<Either> signOut();
  Future<Either> resetPassword(String email);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FlutterSecureStorage secureStorage=sl<FlutterSecureStorage>();

  @override
  Future<Either> signin(SignInUserReq signInUserReq) async{
    try{
      UserCredential data = await firebaseAuth.signInWithEmailAndPassword(
          email: signInUserReq.email,
          password: signInUserReq.password,
      );

       final Either response = await sl<NetworkCallHandler>().call(() =>
              sl<ApiClient>().get("${AppLinks.user}/${data.user!.uid}"));

      if (response.isLeft()) return const Left("You are not a user");

      response.fold((l) => l, (r) async{
        print(r["role"]);
        final role = r["role"]=='patient'?UserRole.patient:UserRole.doctor;
        await sl<RoleService>().saveRole(role);
      },);

      await secureStorage.write(key: 'uid', value: data.user!.uid);
      return const Right("Sign in was Successful");
    }on FirebaseAuthException catch (e) {
      String message ='';
      if (e.code == 'invalid-email') {
        message = 'The email address is badly formatted.';
      } else if (e.code == 'wrong-credential') {
        message = 'The wrong email or password was provided for that user.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createuserReq) async{

    try{
      UserCredential data = await firebaseAuth.createUserWithEmailAndPassword(
          email: createuserReq.email,
          password: createuserReq.password,
      );
      await sl<NetworkCallHandler>().call(()=> sl<ApiClient>().post(
              AppLinks.user,
              body: {
                "userID":data.user?.uid,
                "username":createuserReq.fullName,
                "email":createuserReq.email,
                "role":createuserReq.userRole
              }
      ));

      final response = await _createUser( createuserReq,data.user!.uid);
      await secureStorage.write(key: 'uid', value: data.user!.uid);
      if(response.isLeft()) {
        return Left(response.fold((l) => l.message, (r) => null));
      }
      return const Right("SignUp was Successful");
    }on FirebaseAuthException catch (e) {
      String message ='';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signOut() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.signOut();
      await secureStorage.delete(key: 'uid');
      await sl<RoleService>().clearRole();
      return const Right("Sign out was Successful");
    }catch(e){
      return Left("An error occurred $e");
    }
  }

  @override
  Future<Either> singInWithGoogle() async{

    final GoogleSignIn googleSignIn =GoogleSignIn.instance;
    try{
      await googleSignIn.initialize(
        serverClientId: "318363221520-b2ijh4kl9hrmpdljlkl5h9f3jk6kmslb.apps.googleusercontent.com"
      );

      final GoogleSignInAccount account = await googleSignIn.authenticate();

      final GoogleSignInAuthentication auth = account.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: auth.idToken,
      );

      final result = await firebaseAuth.signInWithCredential(credential);
      return Right(result.user!);
    } catch (e) {
    return Left(e.toString());
    }

  }

  Future <Either<Failure, dynamic>> _createUser(CreateUserReq createuserReq, String uid) async{
    final response = await sl<NetworkCallHandler>().call(
            ()=> sl<ApiClient>().post(
                createuserReq.userRole=="patient"? AppLinks.patient:AppLinks.doctor,
                  body: createuserReq.toJson(uid)
            )
    );
    return response;
  }

  @override
  Future<Either<Failure, dynamic>> resetPassword(String email) async {
    try{
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return const Right("Password reset email sent");
    }on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }catch (e) {
      return const Left(ServerFailure("Unexpected error occurred"));
    }
  }


}