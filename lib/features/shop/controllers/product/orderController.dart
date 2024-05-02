import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/loaders/loader.dart';
import 'package:second_hand_fashion_app/common/widgets/success_screen/success_screen.dart';
import 'package:second_hand_fashion_app/data/repositories/authentication/authentication_repository.dart';
import 'package:second_hand_fashion_app/features/pertonalization/controllers/address_controller.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/cart_controller.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/checkout_controller.dart';
import 'package:second_hand_fashion_app/navigation_menu.dart';
import 'package:second_hand_fashion_app/utils/constants/enums.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/popups/full_screen_loader.dart';

import '../../../../data/repositories/order/order_repository.dart';
import '../../models/order_model.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  ///Variable
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  ///Fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final usersOrders = await orderRepository.fetchUserOrders();
      return usersOrders;
    } catch (e) {
      SHFLoaders.warningSnackBar(title: 'Oh snap!', message: e.toString());
      return [];
    }
  }

  ///Add method for order processing
  void processOrder(double totalAmount) async {
    try {
      //Start loader
      SHFFullScreenLoader.openLoadingDialog(
          'Đang tải đơn hàng của bạn', SHFImages.pencilAnimation);

      //Get user authentication id
      final userId = AuthenticationRepository.instance.authUser.uid;
      if (userId.isEmpty) return;

      //Add detail
      final order = OrderModel(
        //Generate a unique ID for  the order
        id: UniqueKey().toString(),
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        //set date as needed
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      );

      //Save the order to firestore
      await orderRepository.saveOrder(order, userId);

      //Update the cart status
      cartController.clearCart();
      //Show Success Screen
      Get.off(() => SuccessScreen(
            image: SHFImages.orderCompletedAnimation,
            title: 'Đã thanh toán thành công!',
            subTitle: 'Đơn hàng của bạn đã được vận chuyển',
            onPressed: () => Get.offAll(() => const NavigationMenu()),
          ));
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }
}
