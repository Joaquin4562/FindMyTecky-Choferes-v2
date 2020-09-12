import 'package:find_my_tecky_choferes_v2/colors/colors.dart';
import 'package:flutter/material.dart';

class HeadersDetails extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = ColoresApp.primary;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 15;
    final paint2 = Paint();
    paint2.color = ColoresApp.primary;
    paint2.style = PaintingStyle.stroke;
    paint2.strokeWidth = 6;

    final path = Path();
    final path2 = Path();
    path.moveTo(0, size.height * 0.70);
    path.lineTo(size.width, size.height * 0.70);
    canvas.drawPath(path, paint);

    path2.lineTo(0, size.height * 0.9);
    path2.quadraticBezierTo(
        size.width * -0.3, size.height * 0.20, size.width, size.height * 0.5);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}