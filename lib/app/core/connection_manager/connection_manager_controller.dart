import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../helper/app_widgets.dart';
import '../helper/print_log.dart';
import 'connection_type.dart';

class ConnectionManagerController extends GetxController {
  final isInternetConnected = true.obs;
  final connectedStatusMessage = "No Internet Connection".obs;
  final connectionType = ConnectionType.wifi.obs;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    _getConnectivityType();
    _streamSubscription = _connectivity.onConnectivityChanged.listen(
      _handleConnectivityChange,
    );
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    printLog("On close initiated");
  }

  Future<void> _getConnectivityType() async {
    List<ConnectivityResult> results = [];
    try {
      results = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        printLog("PlatformException: $e");
      }
    }
    _updateState(results.isNotEmpty ? results.first : ConnectivityResult.none);
  }

  void _handleConnectivityChange(List<ConnectivityResult> results) {
    _updateState(results.isNotEmpty ? results.first : ConnectivityResult.none);
  }

  void _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType.value = ConnectionType.wifi;
        isInternetConnected.value = true;
        connectedStatusMessage.value = "Wifi Connected";
        break;
      case ConnectivityResult.mobile:
        connectionType.value = ConnectionType.mobileData;
        isInternetConnected.value = true;
        connectedStatusMessage.value = "Mobile Data Connected";
        break;
      case ConnectivityResult.none:
        connectionType.value = ConnectionType.noInternet;
        isInternetConnected.value = false;
        connectedStatusMessage.value = "No Internet Connection";
        break;
      default:
        AppWidgets().getSnackBar(
          title: 'Error',
          message: 'Failed to get connection type',
        );
        break;
    }
  }
}
