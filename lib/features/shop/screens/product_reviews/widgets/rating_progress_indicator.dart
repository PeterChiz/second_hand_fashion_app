import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/features/shop/screens/product_reviews/widgets/progress_indicator_and_rating.dart';

class SHFOverallProductRating extends StatelessWidget {
  const SHFOverallProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: Text(
              '4.8',
              style: Theme.of(context).textTheme.displayLarge,
            )),
        const Expanded(
          flex: 7,
          child: Column(
            children: [
              SHFRatingProgressIndicator(text: '5', value: 1.0,),
              SHFRatingProgressIndicator(text: '4', value: 0.8,),
              SHFRatingProgressIndicator(text: '3', value: 0.6,),
              SHFRatingProgressIndicator(text: '2', value: 0.4,),
              SHFRatingProgressIndicator(text: '1', value: 0.2,),
            ],
          ),
        )
      ],
    );
  }
}
