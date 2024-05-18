import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

class ImagesController extends GetxController{
  static ImagesController get instance => Get.find();

  /// Biến
  Rx<String> selectedProductImage = ''.obs;

  /// -- Lấy tất cả hình ảnh từ sản phẩm và các biến thể
  List<String> getAllProductImages(ProductModel product) {
    // Sử dụng Set để chỉ thêm hình ảnh duy nhất
    Set<String> images = {};

    // Tải hình ảnh thu nhỏ
    images.add(product.thumbnail);
    // Gán hình thu nhỏ là hình ảnh được chọn
    selectedProductImage.value = product.thumbnail;

    // Lấy tất cả hình ảnh từ mô hình Sản phẩm nếu không null.
    if (product.images != null) {
      images.addAll(product.images!);
    }

    // Lấy tất cả hình ảnh từ các Biến thể Sản phẩm nếu không null.
    if (product.productVariations != null || product.productVariations!.isNotEmpty) {
      images.addAll(product.productVariations!.map((variation) => variation.image));
    }

    return images.toList();
  }

  /// -- Hiển thị Hình ảnh phóng to
  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
          () => Dialog.fullscreen(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: SHFSizes.defaultSpace * 2, horizontal: SHFSizes.defaultSpace),
                child: CachedNetworkImage(imageUrl: image),
              ),
              const SizedBox(height: SHFSizes.spaceBtwSections),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 150,
                  child: OutlinedButton(onPressed: () => Get.back(), child: const Text('Đóng')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
