import 'package:dartz/dartz.dart';
import 'package:eghealthcare/core/network/network_info.dart';

import '../error/exception.dart';
import '../error/failure.dart';

class NetworkCallHandler {
  final NetworkInfo networkInfo;

  NetworkCallHandler(this.networkInfo);

  Future<Either<Failure, T>> call<T>(Future<T> Function() action) async {

    if (await networkInfo.isConnected) {
      try {
        final result = await action();
        return Right(result);
        } on ServerException catch(e){
        return Left(ServerFailure(e.message));
      }catch (e) {
        print("NetworkCallHandler========================= $e");
        return Left(ServerFailure("Something went wrong : ${e.toString()}"));
      }
    } else {
      return const Left(NetworkFailure("No internet connection"));
    }
  }

}