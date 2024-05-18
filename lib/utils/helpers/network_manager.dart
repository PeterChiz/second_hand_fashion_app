import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/utils/popups/loader.dart';

/// Quản lý trạng thái kết nối mạng và cung cấp các phương thức để kiểm tra và xử lý thay đổi kết nối
class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  /// Khởi tạo quản lý mạng và thiết lập một luồng để liên tục kiểm tra trạng thái kết nối
  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  /// Cập nhật trạng thái kết nối dựa trên sự thay đổi về kết nối và hiển thị cửa sổ bật lên liên quan khi không có kết nối internet
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    if (_connectionStatus.value == ConnectivityResult.none) {
      SHFLoaders.warningSnackBar(title: 'Không có kết nối internet');
    }
  }

  /// Kiểm tra trạng thái kết nối internet
  /// Trả về 'true' nếu đã kết nối, 'false' nếu ngược lại
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

  /// Hủy hoặc đóng luồng kết nối hoạt động
  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}
