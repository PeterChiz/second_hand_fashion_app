import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/list_tiles/payment_tile.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/shop/models/payment_method_model.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(
        name: 'Thanh toán khi nhận hàng',
        image: SHFImages.successfulPaymentIcon);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(SHFSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SHFSectionHeading(
                  title: 'Chọn phương thức thanh toán',
                  showActionButton: false),
              const SizedBox(height: SHFSizes.spaceBtwSections),
              SHFPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Thanh toán khi nhận hàng',
                      image: SHFImages.successfulPaymentIcon)),
              const SizedBox(height: SHFSizes.spaceBtwItems / 2),
              SHFPaymentTile(
                  paymentMethod:
                      PaymentMethodModel(name: 'VISA', image: SHFImages.visa)),
              const SizedBox(height: SHFSizes.spaceBtwItems / 2),
              SHFPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Thẻ tín dụng/thẻ ghi nợ',
                      image: SHFImages.creditCard)),
              const SizedBox(height: SHFSizes.spaceBtwItems / 2),
              SHFPaymentTile(
                  paymentMethod:
                      PaymentMethodModel(name: 'Momo', image: SHFImages.momo)),
              const SizedBox(height: SHFSizes.spaceBtwItems / 2),
              const SizedBox(height: SHFSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}


