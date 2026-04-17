
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async{
    late final bool result ;
    final List<ConnectivityResult>  connectivityResult = await connectivity.checkConnectivity();

    result = connectivityResult.contains(ConnectivityResult.wifi)||
        connectivityResult.contains(ConnectivityResult.mobile);
    return result;
  }
}