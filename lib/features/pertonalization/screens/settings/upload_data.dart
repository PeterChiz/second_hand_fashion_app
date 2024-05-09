import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/upload_data_controller.dart';

class UploadDataScreen extends StatelessWidget {
  const UploadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadDataController());
    return Scaffold(
      appBar: const SHFAppBar(title: Text('Upload Data'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Profile Body
            Padding(
              padding: const EdgeInsets.all(SHFSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SHFSectionHeading(title: '', showActionButton: false),
                  const SizedBox(height: SHFSizes.spaceBtwItems),
                  ListTile(
                    leading: const Icon(Iconsax.category, size: 28, color: SHFColors.primary),
                    title: Text('Upload Categories', style: Theme.of(context).textTheme.titleMedium),
                    trailing: IconButton(
                      onPressed: () => controller.uploadCategories(),
                      icon: const Icon(Iconsax.arrow_up_1, size: 28, color: SHFColors.primary),
                    ),
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwItems),
                  ListTile(
                    leading: const Icon(Iconsax.shop, size: 28, color: SHFColors.primary),
                    title: Text('Upload Brands', style: Theme.of(context).textTheme.titleMedium),
                    trailing: IconButton(
                      onPressed: () => controller.uploadBrands(),
                      icon: const Icon(Iconsax.arrow_up_1, size: 28, color: SHFColors.primary),
                    ),
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwItems),
                  ListTile(
                    leading: const Icon(Iconsax.shopping_cart, size: 28, color: SHFColors.primary),
                    title: Text('Upload Products', style: Theme.of(context).textTheme.titleMedium),
                    trailing: IconButton(
                      onPressed: () => controller.uploadProducts(),
                      icon: const Icon(Iconsax.arrow_up_1, size: 28, color: SHFColors.primary),
                    ),
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwItems),
                  ListTile(
                    leading: const Icon(Iconsax.image, size: 28, color: SHFColors.primary),
                    title: Text('Upload Banners', style: Theme.of(context).textTheme.titleMedium),
                    trailing: IconButton(
                      onPressed: () => controller.uploadBanners(),
                      icon: const Icon(Iconsax.arrow_up_1, size: 28, color: SHFColors.primary),
                    ),
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwSections),
                  const SHFSectionHeading(title: 'Relationships', showActionButton: false),
                  const Text('Đảm bảo đã tải lên tất cả nội dung trên'),
                  const SizedBox(height: SHFSizes.spaceBtwItems),
                  ListTile(
                    leading: const Icon(Iconsax.link, size: 28, color: SHFColors.primary),
                    title: Text('Tải lên dữ liệu liên quan về thương hiệu và danh mục', style: Theme.of(context).textTheme.titleMedium),
                    trailing: IconButton(
                      onPressed: () => controller.uploadBrandCategory(),
                      icon: const Icon(Iconsax.arrow_up_1, size: 28, color: SHFColors.primary),
                    ),
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwItems),
                  ListTile(
                    leading: const Icon(Iconsax.link, size: 28, color: SHFColors.primary),
                    title: Text('Tải lên danh mục sản phẩm Dữ liệu quan hệ', style: Theme.of(context).textTheme.titleMedium),
                    trailing: IconButton(
                      onPressed: () => controller.uploadProductCategories(),
                      icon: const Icon(Iconsax.arrow_up_1, size: 28, color: SHFColors.primary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
