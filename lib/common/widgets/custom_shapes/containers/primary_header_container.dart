import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../curved_edges/curved_edges_widget.dart';
import 'circular_container.dart';

/// Một widget container với màu nền chính và các cạnh cong.
class SHFPrimaryHeaderContainer extends StatelessWidget {
  /// Tạo một container với màu nền chính và các cạnh cong.
  ///
  /// Tham số:
  ///   - child: Widget sẽ được đặt bên trong container.
  const SHFPrimaryHeaderContainer({
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SHFCurvedEdgesWidget(
      child: Container(
          color: SHFColors.primary,
          padding: const EdgeInsets.only(bottom: 0),
          child: Stack(
            children: [
              /// Hình dạng tùy chỉnh nền
              Positioned(top: -150,right: -250,child: SHFCircularContainer(backgroundColor: SHFColors.textWhite.withOpacity(0.1),)),
              Positioned(top: 100,right: -300,child: SHFCircularContainer(backgroundColor: SHFColors.textWhite.withOpacity(0.1),)),
              child,
            ],
          )
      ),
    );
  }
}

