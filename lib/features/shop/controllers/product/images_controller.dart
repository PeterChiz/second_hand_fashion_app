import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

class ImagesController extends GetxController{
  static ImagesController get instance => Get.find();

  ///Variable
  Rx<String> selectedProductImage = ''.obs;

  ///Get all images from product and variations
  List<String> getAllProductImages(ProductModel product){
    //Use get to add unique images only
    Set<String> images = {};

    //Load thumbnail image
    images.add(product.thumbnail);

    //Assign Thumbnail as Selected Image
    selectedProductImage.value = product.thumbnail;

    //Get all images from the Product Model if not null
    if(product.images != null){
      images.addAll(product.images!);
    }

    //Get all images from the Product Variations id not null
    if(product.productVariations != null || product.productVariations!.isNotEmpty){
      images.addAll(product.productVariations!.map((variation) => variation.image));
    }
    return images.toList();
  }

  ///Show image popup
  void showEnlargedImage(String image){
    Get.to(
      fullscreenDialog:  true,
        () => Dialog.fullscreen(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: SHFSizes.defaultSpace * 2, horizontal: SHFSizes.defaultSpace),
              child: CachedNetworkImage(imageUrl: image,),
              ),
              const SizedBox(height: SHFSizes.spaceBtwSections,),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 150,
                  child: OutlinedButton(onPressed: () => Get.back(), child: const Text('Close')),
                ),
              )
            ],
          ),
        )
    );
  }
}