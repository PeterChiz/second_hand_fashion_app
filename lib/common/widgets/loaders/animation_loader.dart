import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

///A widget for displaying an animated loading indicator with optional text and action button
class SHFAnimationLoaderWidget extends StatelessWidget {
  ///Hàm tạo mặc định cho SHFAnimationLoaderWidget
  ///
  /// Thông số:
  /// text: Văn bản sẽ hiển thị bên dưới ảnh động
  /// animation: Đường dẫn tới file ảnh động Lottie
  /// showAction: Có hiển thị nút hành động hay không
  /// onActionPressed: Hàm gọi lại được thực thi khi hành động được nhấn
  const SHFAnimationLoaderWidget({super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed});

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation, width: MediaQuery
              .of(context)
              .size
              .width * 0.8), //Display Lottie animation
          const SizedBox(height: SHFSizes.defaultSpace,),
          Text(
            text,
            style: Theme
                .of(context)
                .textTheme
                .bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: SHFSizes.defaultSpace,),
          showAction
              ? SizedBox(
            width: 250,
            child: OutlinedButton(onPressed: onActionPressed,
                style: OutlinedButton.styleFrom(backgroundColor: SHFColors.dark),
                child: Text(actionText!, style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: SHFColors.light),)),

          ) : const SizedBox(),
        ],
      ),
    );
  }
}
