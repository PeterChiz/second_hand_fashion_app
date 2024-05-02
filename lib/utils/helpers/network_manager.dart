import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/loaders/loader.dart';

///Manager the network connectivity status and provides methods to check and handle connectivity changes
class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  ///Initialize the network manager and set up a stream to continually check the connection status
  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  ///Cập nhật trạng thái kết nối dựa trên những thay đổi về kết nối và hiển thị cửa sổ bật lên có liên quan khi không có kết nối internet
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    if (_connectionStatus.value == ConnectivityResult.none) {
      SHFLoaders.warningSnackBar(title: 'Không có kết nối internet');
    }
  }

  ///Check the internet connection status
  ///Return 'true' if connected, 'false' otherwise
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException {
      return false;
    }
  }

  /// Dispose or close the active connectivity stream
  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}