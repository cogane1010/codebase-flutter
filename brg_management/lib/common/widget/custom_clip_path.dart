import 'package:flutter/material.dart';

class CustomClipPath extends CustomClipper<Path> {
  var radius = 12.0;

  // 0 -> outside
  // 1 -> inside
  final position;
  final bool isClipTopLeft;
  final bool isClipBottomRight;

  CustomClipPath(this.position,
      {this.isClipTopLeft = false, this.isClipBottomRight = false});

  @override
  Path getClip(Size size) {
    if (position == 0) {
      radius = 12;
    } else {
      radius = 11;
    }

    Path path = Path();
    path.moveTo(radius, 0.0);

    // clip top left

    path.arcToPoint(Offset(isClipTopLeft ? radius : 0, 0), clockwise: true);
    path.lineTo(0.0, radius);

    path.arcToPoint(Offset(0, size.height), clockwise: true);
    path.lineTo(size.width - radius, size.height);

    // clip bottom right
    path.arcToPoint(Offset(size.width, size.height - radius), clockwise: true);
    path.lineTo(size.width, 0);

    path.arcToPoint(Offset(size.width - radius, 0.0), clockwise: true);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
