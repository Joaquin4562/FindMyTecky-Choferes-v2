import 'package:find_my_tecky_choferes_v2/colors/colors.dart';
import 'package:flutter/material.dart';

class HeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = ColoresApp.primaryLigth;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 20;
    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.20, size.height * 0.80,
        size.width * 0.5, size.height * 0.9);
    path.quadraticBezierTo(
        size.width * 0.90, size.height + 30, size.width, size.height * 0.9);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}