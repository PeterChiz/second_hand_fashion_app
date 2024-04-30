import 'package:get/get.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/variation_controller.dart';
import 'package:second_hand_fashion_app/utils/helpers/network_manager.dart';

class GeneralBinding extends Bindings {

  @override
  void dependencies(){
    Get.put(NetworkManager());
    Get.put(VariationController());
  }
}
