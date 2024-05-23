import 'dart:ui';

import 'package:flutter/material.dart';

class LocalUserVideoWidgetCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double radius = 10.0; // Adjust the radius as needed
    Path path = Path()
      ..moveTo(radius, 0)
      ..lineTo(size.width - radius, 0)
      ..arcToPoint(Offset(size.width, radius),
          radius: const Radius.circular(radius))
      ..lineTo(size.width, size.height - radius)
      ..arcToPoint(Offset(size.width - radius, size.height),
          radius: const Radius.circular(radius))
      ..lineTo(radius, size.height)
      ..arcToPoint(Offset(0, size.height - radius),
          radius: const Radius.circular(radius))
      ..lineTo(0, radius)
      ..arcToPoint(const Offset(radius, 0),
          radius: const Radius.circular(radius))
      ..close();

    // final width = size.width;
    // final height = size.height;
    // Path path = Path();
    // path.moveTo(width * 0.03, 0);
    // path.quadraticBezierTo(width * 0.01, height * 0.02, 0, height * 0.04);
    // path.lineTo(0, height * 0.99);
    // path.quadraticBezierTo(width * 0.005, height * 0.995, width * 0.01, height);
    // path.lineTo(width * 0.995, height);
    // path.quadraticBezierTo(width * 0.995, height * 0.995, width, height * 0.99);
    // path.lineTo(width, height * 0.01);
    // path.quadraticBezierTo(width * 0.995, height * 0.005, width * 0.995, 0);
    // path.lineTo(width * 0.03, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
