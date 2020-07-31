import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnowmanPage extends StatefulWidget {
  @override
  _SnowmanPageState createState() => _SnowmanPageState();
}

class _SnowmanPageState extends State<SnowmanPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
//      constraints: BoxConstraints(),
      width: double.infinity,
      height: double.infinity,
      color: Colors.blue,
      child: CustomPaint(
        painter: MyPainter(),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  /**
   * ??
   */
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    print("size ${size}");
    Paint paint = Paint()..color = Colors.white;
//    for
    Snowflake snowflake = Snowflake();
    canvas.drawCircle(
        Offset(snowflake.x, snowflake.y), snowflake.radius, paint);

    canvas.drawCircle(size.center(Offset(0, 80)), size.width / 6, paint);
    canvas.drawOval(
        Rect.fromCenter(
            center: size.center(Offset(0, 100 + size.width / 3)),
            width: size.width * 4 / 7,
            height: 100 + size.width / 3),
        paint);
  }

  /**
   * ????
   */
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class Snowflake {
  double x = Random().nextDouble() *400;
  double y = Random().nextDouble();
  double radius = 5.0;
}
