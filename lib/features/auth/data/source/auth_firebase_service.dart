import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user.dart';
import '../models/create_user_req.dart';
import '../models/signin_user_req.dart';
import '../models/user.dart';

abstract class AuthFirebaseService{
  Future<Either> signup(CreateUserReq createuserReq);
  Future<Either> signin(SignInUserReq signInUserReq);
  Future<Either> getUser();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService{
  @override
  Future<Either> signin(SignInUserReq signInUserReq) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signInUserReq.email,
          password: signInUserReq.password
      );
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
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createuserReq.email,
          password: createuserReq.password
      );
      FirebaseFirestore.instance.collection('Users').doc(data.user!.uid)
          .set({
        "name":createuserReq.fullName,
        "email":data.user!.email,
      });
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
  Future<Either> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore.collection('Users').doc(
          firebaseAuth.currentUser!.uid
      ).get();
      UserModel userModel = UserModel.fromJson((user).data()!);
      userModel.imageURL = firebaseAuth.currentUser!.photoURL ?? "";//AppURLs.defaultImage
      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    }catch(e){
      return Left("An error occurred $e");
    }
  }

}