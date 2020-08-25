import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DragPage extends StatefulWidget {
  DragPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _DragState();
  }
}

class _DragState extends State<DragPage> {
  var _color = Colors.blue;
  List<ColorDes> _colors = [];
  int _slot;
  double offset;

  _shuffle() {
    _color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    _colors = List.generate(9, (index) {
      return  ColorDes(_color[(index+1)*100],(index+1)*100);
    });
    setState(() => _colors.shuffle());
  }

  final _globalKey = GlobalKey();

  void _onDrag(color) {
    _slot = _colors.indexOf(color);
    final renderBox =
        (_globalKey.currentContext.findRenderObject() as RenderBox);
    offset = renderBox.localToGlobal(Offset.zero).dy;
  }

  void _onPointerMove(event) {
    double dy = event.position.dy - offset;
    if (dy > (_slot + 1) * Box.height) {
      if (_slot == _colors.length - 1) return;
      setState(() {
        final c = _colors[_slot];
        _colors[_slot] = _colors[_slot + 1];
        _colors[_slot + 1] = c;
        _slot++;
      });
    } else if (dy < _slot * Box.height) {
      if (_slot == 0) return;
      setState(() {
        final c = _colors[_slot];
        _colors[_slot] = _colors[_slot - 1];
        _colors[_slot - 1] = c;
        _slot--;
      });
    }
  }


  _checkColorCondition() {
    List<double> lum = _colors.map((e) => e.color.computeLuminance()).toList();
    bool suc = true;
    for (int i = 0; i < lum.length - 1; i++) {
      if (lum[i] > lum[i + 1]) {
        suc = false;
        break;
      }
    }
    print("$suc");
    if (suc) {
      Fluttertoast.showToast(
          msg: "Congratulations on your success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.black);
    }
  }

  @override
  void initState() {
    super.initState();
    _shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Text(
                "请手动拖拽方块,按照颜色从深到浅排列",
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Listener(
                  onPointerMove: (event) {
                    this._onPointerMove(event);
                  },
                  child: SizedBox(
                    width: Box.width,
                    child: Stack(
                      key: _globalKey,
                      children: List.generate(_colors.length, (index) {
                        return Box(
                          colorDes: _colors[index],
                          top: index * Box.height,
                          left: 0,
                          onDrag: (ColorDes color) {
                            this._onDrag(color);
                          },
                          onEnd: _checkColorCondition,
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: FloatingActionButton(
            onPressed: _shuffle,
            tooltip: 'Increment',
            child: Icon(Icons.refresh),
          ),
        )

      ],
    );
  }
}

class Box extends StatelessWidget {
  final ColorDes colorDes;
  final double top, left;
  final Function(ColorDes color) onDrag;
  final Function() onEnd;
  static const width = 200.0;
  static const height = 60.0;
  static const margin = 5.0;

  Box(
      {@required this.colorDes,
      @required this.top,
      @required this.left,
      @required this.onDrag,
      @required this.onEnd})
      : super(key: ValueKey(colorDes.key));

  @override
  Widget build(BuildContext context) {
    final container = Container(
      width: width - 2 * margin,
      height: height - 2 * margin,
      decoration:
          BoxDecoration(color: colorDes.color, borderRadius: BorderRadius.circular(5)),
    );

    return AnimatedPositioned(
      key: ValueKey(colorDes.key),
      duration: Duration(milliseconds: 500),
      top: this.top,
      left: 0,
      child: Draggable(
        child: container,
        feedback: container,
        childWhenDragging: Visibility(
          child: container,
          visible: false,
        ),
        onDragStarted: () {
          print("onDragStarted");
          this.onDrag(colorDes);
        },
        onDragEnd: (detail) {
          print("onDragEnd");
          ;
        },
        onDragCompleted: () {
          print("onDragCompleted");
        },
        onDraggableCanceled: (v, offset) {
          print("onDraggableCanceled");
          this.onEnd();
        },
      ),
    );
  }
}

class ColorDes{

  Color color;
  int key;

  ColorDes(this.color, this.key);
}
