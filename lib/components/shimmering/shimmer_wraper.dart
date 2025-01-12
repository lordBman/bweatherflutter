import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWrapper extends StatelessWidget{
    final Widget child;
    final bool enabled;
    const ShimmerWrapper({ super.key, this.enabled = true, required this.child });

    @override
    Widget build(BuildContext context) {
        return Shimmer.fromColors(
            baseColor: Colors.blueGrey.shade200,
            highlightColor: Colors.blueGrey.shade50,
            enabled: enabled,
            child: child);
    }
}