import 'package:flutter/material.dart';

import 'curved_edges.dart';

class SHFCurvedEdgeWidget extends StatelessWidget {
  const SHFCurvedEdgeWidget({
    super.key, this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: SHFCustomCurvedEdges(),
      child: child,
    );
  }
}