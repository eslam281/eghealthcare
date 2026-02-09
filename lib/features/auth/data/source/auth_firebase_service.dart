import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/entities/user.dart';
import '../models/create_user_req.dart';
import '../models/signin_user_req.dart';
import '../models/user.dart';

abstract class AuthFirebaseService{
  Future<Either> signup(CreateUserReq createuserReq);
  Future<Either> signin(SignInUserReq signInUserReq);
  Future<Either> singInWithGoogle();
  Future<Either> getUser();
  Future<Either> signOut();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Either> signin(SignInUserReq signInUserReq) async{
    try{
      await firebaseAuth.signInWithEmailAndPassword(
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
      var data = await firebaseAuth.createUserWithEmailAndPassword(
          email: createuserReq.email,
          password: createuserReq.password
      );
      // FirebaseFirestore.instance.collection('Users').doc(data.user!.uid)
      //     .set({
      //   "name":createuserReq.fullName,
      //   "email":data.user!.email,
      // });
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

      // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      //
      // var user = await firebaseFirestore.collection('Users').doc(
      //     firebaseAuth.currentUser!.uid
      // ).get();
      // UserModel userModel = UserModel.fromJson((user).data()!);
      // userModel.imageURL = firebaseAuth.currentUser!.photoURL ?? "";//AppURLs.defaultImage
      // UserEntity userEntity = userModel.toEntity();
      // return Right(userEntity);
      return  Right(firebaseAuth.currentUser!);
    }catch(e){
      return Left("An error occurred $e");
    }
  }

  @override
  Future<Either<dynamic, dynamic>> signOut() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      //
      // await firebaseFirestore.collection('Users').doc(
      //     firebaseAuth.currentUser!.uid
      // ).delete();

      await firebaseAuth.signOut();

      return const Right("Sign out was Successful");
    }catch(e){
      return Left("An error occurred $e");
    }
  }

  @override
  Future<Either<dynamic, dynamic>> singInWithGoogle() async{

    final GoogleSignIn googleSignIn =GoogleSignIn.instance;
    try{
      // لازم initialize مرة واحدة
      await googleSignIn.initialize(
        serverClientId: "318363221520-b2ijh4kl9hrmpdljlkl5h9f3jk6kmslb.apps.googleusercontent.com"
      );

      // يبدأ عملية تسجيل الدخول
      final GoogleSignInAccount account = await googleSignIn.authenticate();

      // نجيب التوكنات
      final GoogleSignInAuthentication auth = account.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: auth.idToken,
      );

      final result = await firebaseAuth.signInWithCredential(credential);
      return Right(result.user!);
    } catch (e) {
      print(e.toString());
    return Left(e.toString());
    }

  }

}