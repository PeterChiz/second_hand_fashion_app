import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/cart_controller.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/features/shop/screens/product_details/product_detail.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/enums.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  const ProductCardAddToCartButton({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return GestureDetector(
      onTap: () {
        // Nếu sản phẩm có biến thể thì hiển thị chi tiết sản phẩm để chọn biến thể.
        // Ngược lại, thêm sản phẩm vào giỏ hàng.
        if (product.productType == ProductType.single.toString()) {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        } else {
          Get.to(() => ProductDetailScreen(product: product));
        }
      },
      child: Obx(
            () {
          final productQuantityInCart = cartController.getProductQuantityInCart(product.id);
          return AnimatedContainer(
            curve: Curves.easeInOutCubicEmphasized,
            decoration: BoxDecoration(
              color: productQuantityInCart > 0 ? SHFColors.primary : SHFColors.dark,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(SHFSizes.cardRadiusMd),
                bottomRight: Radius.circular(SHFSizes.productImageRadius),
              ),
            ),
            duration: const Duration(milliseconds: 300),
            child: SizedBox(
              width: SHFSizes.iconLg * 1.2,
              height: SHFSizes.iconLg * 1.2,
              child: Center(
                child: productQuantityInCart > 0
                    ? Text(productQuantityInCart.toString(), style: Theme.of(context).textTheme.bodyLarge!.apply(color: SHFColors.white))
                    : const Icon(Iconsax.add, color: SHFColors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
