import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnowmanPage extends StatefulWidget {
  @override
  _SnowmanPageState createState() => _SnowmanPageState();
}

class _SnowmanPageState extends State<SnowmanPage>  with SingleTickerProviderStateMixin{
  AnimationController _controller;

  List<Snowflake> _snowflaks=List.generate(200, (index) => Snowflake());


  @override
  void initState() {
    super.initState();
    _controller=AnimationController(
      duration: Duration(seconds: 1),
      vsync: this
    )..repeat();

  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
//      constraints: BoxConstraints(),
      width: double.infinity,
      height: double.infinity,

      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue,Colors.lightBlue,Colors.white],
          stops: [0.0,0.7,0.97]
        )
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context,Widget child){
          _snowflaks.forEach((element) {element.fall();});
          return CustomPaint(
            painter: MyPainter(_snowflaks),
          );
        },
      ),
    );
  }
}

class MyPainter extends CustomPainter {

  List<Snowflake> _snowflaks;


  MyPainter(this._snowflaks);

  /**
   * ??
   */
  @override
  void paint(Canvas canvas, Size size) {
    print("size ${size}");
    Paint paint = Paint()..color = Colors.white;
//    for
    _snowflaks.forEach((snowflake) {
      canvas.drawCircle(
          Offset(snowflake.x, snowflake.y), snowflake.radius, paint);
    });


    canvas.drawCircle(size.center(Offset(-65, 80)), size.width / 9, paint);
    canvas.drawOval(
        Rect.fromCenter(
            center: size.center(Offset(-65, 100 + size.width / 4)),
            width: size.width * 3 / 8,
            height: 100 + size.width / 4),
        paint);

    canvas.drawCircle(size.center(Offset(60, 130)), size.width / 14, paint);
    canvas.drawOval(
        Rect.fromCenter(
            center: size.center(Offset(60, 160 + size.width / 6)),
            width: size.width * 3 / 11,
            height: 100 + size.width / 6),
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
  double y = Random().nextDouble()*600;
  double radius = Random().nextDouble()*2+2;//大小
  double valocity = Random().nextDouble()*4+2;//速度
  fall(){
    y+=valocity;
    if(y>600){
      y=0;
      double x = Random().nextDouble() *400;
      double radius = Random().nextDouble()*2+2;
      double valocity = Random().nextDouble()*4+2;
    }
  }
}
