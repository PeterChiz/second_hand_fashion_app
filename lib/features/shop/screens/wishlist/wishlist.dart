import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/icons/shf_circular_icon.dart';
import 'package:second_hand_fashion_app/common/widgets/layouts/grid_layout.dart';
import 'package:second_hand_fashion_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/features/shop/screens/home/home.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SHFAppBar(
        title: Text(
          'Danh sách yêu thích',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          SHFCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            children: [
              SHFGridLayout(
                itemCount: 6,
                itemBuilder: (_, index) =>  SHFProductCardVertical(product: ProductModel.empty(),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
