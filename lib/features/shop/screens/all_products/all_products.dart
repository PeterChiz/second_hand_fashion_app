import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/all_products_controller.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/cloud_helper_functions.dart';

import '../../../../common/widgets/products/sortable/sortable_products.dart';
import '../../models/product_model.dart';

class AllProducts extends StatelessWidget {
  const AllProducts(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    //Initialize controller for managing product fetching
    final controller = Get.put(AllProductController());

    return Scaffold(
      ///Appbar
      appBar: SHFAppBar(
        title: Text(title),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: FutureBuilder(
              future: futureMethod ?? controller.fetchProductByQuery(query),
              builder: (context, snapshot) {
                // Kiem tra trang thai cua FutureBuilder snapshot
                const loader = SHFVerticalProductShimmer();
                final widget = SHFCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);

                //Return appropriate widget based on snapshot state
                if(widget != null) return widget;

                //Popular found
                final products = snapshot.data!;
                return  SHFSortableProducts(products: products,);
              }),
        ),
      ),
    );
  }
}
