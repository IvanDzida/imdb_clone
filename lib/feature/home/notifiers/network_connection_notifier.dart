import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


class NetworkConnectionNotifier extends StateNotifier<bool> {
  bool isDeviceConnected;
  late StreamSubscription subscription;

  NetworkConnectionNotifier(this.isDeviceConnected) : super(true) {
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
