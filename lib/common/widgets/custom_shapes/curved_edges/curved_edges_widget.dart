import 'package:flutter/material.dart';

import 'curved_edges.dart';

/// Widget này thêm các cạnh cong vào child của nó bằng cách sử dụng một custom clipper.
class SHFCurvedEdgesWidget extends StatelessWidget {
  /// Tạo một widget với các cạnh cong.
  const SHFCurvedEdgesWidget({
    super.key,
    required this.child,
  });

  /// Widget con để được bọc bởi các cạnh cong.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      // Sử dụng custom clipper để tạo các cạnh cong
      clipper: SHFCustomCurvedEdges(),
      child: child,
    );
  }
}
