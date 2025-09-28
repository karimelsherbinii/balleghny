import 'package:internet_connection_checker/internet_connection_checker.dart';

// contracting
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

//implmentaiton
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl({required this.connectionChecker});
  @override
  Future<bool> get isConnected async => await connectionChecker.hasConnection;
}
