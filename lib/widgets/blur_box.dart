import 'dart:ui';

import 'package:flutter/material.dart';

class BlurBox extends StatelessWidget {
  final Widget? child;
  final double? height;
  final Alignment? alignment;
  final Color backgroundColor;
  final Color borderColor;

  const BlurBox({
    Key? key,
    this.child,
    this.height,
    this.alignment,
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          // Blur Background
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // Blur Background
            color: backgroundColor,
            border: Border.all(
              color: borderColor.withOpacity(0.4),
              width: 1,
            ),
          ),
          alignment: alignment ?? Alignment.topLeft,
          // If height is not provided, use the default height
          height: height,
          // height: height ?? MediaQuery.of(context).size.height,
          child: child,
        ),
      ),
    );
  }
}
