import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/features/shop/screens/product_reviews/widgets/progress_indicator_and_rating.dart';
import 'package:second_hand_fashion_app/features/shop/screens/product_reviews/widgets/rating_star.dart';
import 'package:second_hand_fashion_app/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

import '../../controllers/dummy_data.dart';


class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// -- Appbar
      appBar: const SHFAppBar(title: Text('Reviews & Ratings'), showBackArrow: true),

      /// -- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// -- Reviews List
              const Text("Ratings and reviews are verified and are from people who use the same type of device that you use."),
              const SizedBox(height: SHFSizes.spaceBtwItems),

              /// Overall Product Ratings
              const SHFOverallProductRating(),
              const SHFRatingBarIndicator(rating: 3.5),
              const Text("12,611"),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              /// User Reviews List
              ListView.separated(
                shrinkWrap: true,
                itemCount: SHFDummyData.productReviews.length,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(height: SHFSizes.spaceBtwSections),
                itemBuilder: (_, index) => UserReviewCard(productReview: SHFDummyData.productReviews[index]),
              )
            ],
          ),
        ),
      ),
    );
  }
}



