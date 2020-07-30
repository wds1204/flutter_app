import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TranstionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TranstionPageState();
  }
}

class _TranstionPageState extends State<TranstionPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool open = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
//      lowerBound: 0.5,
//      upperBound:1.0,
      vsync: this,
    )..repeat(reverse:true);
    _controller.addListener(() {
//      print("${_controller.value}");
    });
  }

  @override
  void dispose() {
    _controller.reset();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ScaleTransition(
              scale: _controller.drive(Tween(begin: 0.5, end: 1.0)),
//          turns: _controller.drive(Tween(begin: 0.5,end: 2.0)),//_controller,
              child: Container(
                width: 200,
                height: 100,
                color: Colors.blue,
              ),
            ),

            SlideContain(_controller, Colors.blue[100], Interval(0,0.2)),
            SlideContain(_controller, Colors.blue[300], Interval(0.2,0.4)),
            SlideContain(_controller, Colors.blue[500], Interval(0.4,0.6)),
            SlideContain(_controller, Colors.blue[700], Interval(0.6,0.8)),
            SlideContain(_controller, Colors.blue[900], Interval(0.8,1.0)),
            RaisedButton(
              child: Text('点击'),
              onPressed: () {
                //forward()运行一次、repeat()无限循环、reset()是重置回到原点、stop()暂停
//           !open? _controller.repeat():_controller.stop();
                _controller.forward();
//           open=!open;

              },
            ),
          ],
        ));
  }
}

class SlideContain extends StatelessWidget {
  final AnimationController controller;
  final Color color;
  final Interval interval;

  SlideContain(this.controller, this.color, this.interval);

  @override
  Widget build(BuildContext context) {
    return  SlideTransition(
        position: Tween(begin: Offset.zero,end:Offset(0.15,0) ).
            chain(CurveTween(curve:Curves.bounceOut)).
        chain(CurveTween(curve: interval)).animate(controller),
        child: Container(width: 300, height: 80, color: color)
    );
  }
}


