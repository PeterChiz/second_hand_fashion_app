import 'package:get/get.dart';
import 'package:second_hand_fashion_app/utils/helpers/network_manager.dart';

class GeneralBinding extends Bindings {

  @override
  void dependencies(){
    Get.put(NetworkManager());
  }
}
