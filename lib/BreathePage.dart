import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BreathePage extends StatefulWidget {
  @override
  _BreathePageState createState() => _BreathePageState();
}

class _BreathePageState extends State<BreathePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 4)
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(

          builder: (BuildContext context, Widget child) {
            return Container(
              height: 280,
              width: 280,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  gradient: RadialGradient(
                      colors: [
                        Colors.blue[600],
                        Colors.blue[100],
                      ],
                      stops: [//默认是是0～1均匀渐变，在第一个值前，全部由第一个color值填充，
                        _controller.value,  _controller.value+0.1
                      ]
                  )
              ),
            );
          },
          animation: _controller,
      ),
    );
  }
}
