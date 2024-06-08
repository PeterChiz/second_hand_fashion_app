import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/utils/popups/loader.dart';
import 'package:second_hand_fashion_app/common/widgets/success_screen/success_screen.dart';
import 'package:second_hand_fashion_app/data/repositories/authentication/authentication_repository.dart';
import 'package:second_hand_fashion_app/features/pertonalization/controllers/address_controller.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/cart_controller.dart';
import 'package:second_hand_fashion_app/navigation_menu.dart';
import 'package:second_hand_fashion_app/utils/constants/enums.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/popups/full_screen_loader.dart';

import '../../../../data/repositories/order/order_repository.dart';
import '../../../../data/services/paypal/paypal.dart';
import '../../models/order_model.dart';
import '../checkout_controller.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  /// Variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  /// Lấy lịch sử đặt hàng của người dùng
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      SHFLoaders.warningSnackBar(title: 'Có lỗi!', message: e.toString());
      return [];
    }
  }

  /// Thêm phương thức xử lý đơn hàng
  void processOrder(double totalAmount) async {
    try {
      // Start Loader
      SHFFullScreenLoader.openLoadingDialog('Đang xử lý đơn đặt hàng của bạn', SHFImages.pencilAnimation);
      // Nhận Id xác thực người dùng
      final userId = AuthenticationRepository.instance.getUserID;
      if (userId.isEmpty) return;
      // Thêm Details
      final order = OrderModel(
        // Tạo ID duy nhất cho đơn hàng
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        // Đặt ngày nếu cần
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      );
      // Cổng thanh toán kích hoạt
      if(checkoutController.selectedPaymentMethod.value.name == PaymentMethods.momo.name) {
        await SHFMomoService.getPayment();
      }
      // Lưu đơn hàng vào Firestore
      await orderRepository.saveOrder(order, userId);
      // Cập nhật trạng thái giỏ hàng
      cartController.clearCart();
      // Hiển thị màn hình Thành công
      Get.off(() => SuccessScreen(
        image: SHFImages.checkout,
        title: 'Thanh toán thành công!',
        subTitle: 'Mặt hàng của bạn sẽ được vận chuyển sớm!',
        onPressed: () => Get.offAll(() => const NavigationMenu()),
      ));
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }
}
