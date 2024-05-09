import 'package:get/get.dart';
import 'package:second_hand_fashion_app/features/pertonalization/controllers/address_controller.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/variation_controller.dart';
import 'package:second_hand_fashion_app/utils/helpers/network_manager.dart';

import '../features/shop/controllers/checkout_controller.dart';
import '../features/shop/controllers/product/images_controller.dart';

class GeneralBinding extends Bindings {

  @override
  void dependencies(){
    /// -- Core
    Get.put(NetworkManager());

    /// -- Product
    Get.put(CheckoutController());
    Get.put(VariationController());
    Get.put(ImagesController());

    /// -- Other
    Get.put(AddressController());
  }
}
