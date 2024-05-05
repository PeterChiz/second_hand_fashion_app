import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../curved_edges/curved_edges_widget.dart';
import 'circular_container.dart';

/// A container widget with a primary color background and curved edges.
class SHFPrimaryHeaderContainer extends StatelessWidget {
  /// Create a container with a primary color background and curved edges.
  ///
  /// Parameters:
  ///   - child: The widget to be placed inside the container.
  const SHFPrimaryHeaderContainer({
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SHFCurvedEdgeWidget(
      child: Container(
          color: SHFColors.primary,
          padding: const EdgeInsets.only(bottom: 0),
          child: Stack(
            children: [
              ///Background Custom Shape
              Positioned(top: -150,right: -250,child: SHFCircularContainer(backgroundColor: SHFColors.textWhite.withOpacity(0.1),)),
              Positioned(top: 100,right: -300,child: SHFCircularContainer(backgroundColor: SHFColors.textWhite.withOpacity(0.1),)),
              child,
            ],
          )
      ),
    );
  }
}
