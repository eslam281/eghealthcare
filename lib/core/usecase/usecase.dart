abstract class UseCase<Future_Type,Params>{
  Future<Future_Type> call({Params params});
}