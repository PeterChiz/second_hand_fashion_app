import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';


class SHFRatingBarIndicator extends StatelessWidget {
  const SHFRatingBarIndicator({
    super.key, required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
        rating: rating,
        itemSize: 20,
        unratedColor: SHFColors.grey,
        itemBuilder: (_,__) => const Icon(Iconsax.star1, color: SHFColors.primary,));
  }
}