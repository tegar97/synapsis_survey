import 'package:synapsis_survey/core/platform/network_info_interface.dart';
import "package:connectivity_plus/connectivity_plus.dart";

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> isConnected() async {
    final connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivity == ConnectivityResult.mobile) {
      return true;
    }
    return false;
  }
}
