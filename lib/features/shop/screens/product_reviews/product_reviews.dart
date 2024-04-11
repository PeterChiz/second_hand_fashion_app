import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:second_hand_fashion_app/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

import '../../../../common/widgets/products/ratings/rating_indicator.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Appbar
      appBar: const SHFAppBar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true,
      ),

      ///Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Ratings and Reviews are verified and are from people who use the same type of device that you use.'),
              const SizedBox(
                height: SHFSizes.spaceBtwItems,
              ),

              ///Overall Product Ratings
              const SHFOverallProductRating(),
              const SHFRatingBarIndicator(rating: 3.5,),
              Text('123', style: Theme.of(context).textTheme.bodySmall,),
              const SizedBox(height: SHFSizes.spaceBtwSections,),

              ///User Reviews List
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}



