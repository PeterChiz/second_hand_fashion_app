import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:second_hand_fashion_app/common/widgets/products/ratings/rating_indicator.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(SHFImages.userProfileImage1),),
                const SizedBox(width: SHFSizes.spaceBtwItems,),
                Text('John Senna', style: Theme.of(context).textTheme.titleLarge,),
              ],
            ),
            IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(height: SHFSizes.spaceBtwItems,),

        ///Reviews
        Row(
          children: [
            const SHFRatingBarIndicator(rating: 4),
            const SizedBox(width: SHFSizes.spaceBtwItems,),
            Text('02 Apr, 2024',style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(height: SHFSizes.spaceBtwItems,),
        const ReadMoreText(
            'Chất lượng sản phẩm: quá là tuyệt vời. Lần đầu tiên mua hàng có giá trị lớn mà ko phải cửa hàng Mall. Shop tư vấn nhiệt tình, hỗ trợ trên cả tuyệt vời. Sản phẩm mới, đúng mã.',
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: ' show less',
          trimCollapsedText: ' show more',
          moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: SHFColors.primary),
          lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: SHFColors.primary),
        ),
        const SizedBox(height: SHFSizes.spaceBtwItems,),

        ///Company Review
        SHFRoundedContainer(
          backgroundColor: dark ? SHFColors.darkerGrey : SHFColors.grey,
          child: Padding(
            padding: const  EdgeInsets.all(SHFSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('HÒA Second Hand', style: Theme.of(context).textTheme.titleMedium,),
                    Text('03, Apr, 2024', style: Theme.of(context).textTheme.bodyMedium,),
                  ],
                ),
                const SizedBox(height: SHFSizes.spaceBtwItems,),
                const ReadMoreText(
                  'Cảm ơn bạn đã ủng hộ cửa hàng. Sự hài lòng của bạn là mối quan tâm số một của chúng tôi. Vì vậy, hãy phản ánh nếu bạn có bất kỳ điều gì chưa hài lòng. Chúng tôi sẽ tiếp nhận và cải thiện để mang tới trải nghiệm tốt nhất cho khách hàng.',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: ' show less',
                  trimCollapsedText: ' show more',
                  moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: SHFColors.primary),
                  lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: SHFColors.primary),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: SHFSizes.spaceBtwSections,),
      ],
    );
  }
}
