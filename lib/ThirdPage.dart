import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(

      child: ThirdContent(),
    );
  }
}

class ThirdContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ThirdWidget();
  }
}

class ThirdWidget extends State<ThirdContent> {
  double size=200;
  double radius=0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return
      Column(
        mainAxisAlignment:MainAxisAlignment.spaceAround,

        children:
        <Widget>[
          AnimatedContainer(
            curve:Curves.bounceOut,
            duration: Duration(milliseconds: 800),
            alignment:Alignment.center,
            width: size,
            height: size,
//            transform: Matrix4.skewY(0.3),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
                borderRadius:BorderRadius.only(
                  bottomLeft: Radius.circular(radius),
                  topRight: Radius.circular(radius),
                  bottomRight: Radius.circular(radius), topLeft:Radius.circular(radius))
            ),
            child: AnimatedSwitcher(
              transitionBuilder: (child,animation){
                return ScaleTransition(
                    child:child,
                  scale: animation,
                );
              },

              duration: Duration(seconds: 1),
              child: Image.network("https://wx4.sinaimg.cn/mw690/69b47d90ly1gh1s68l6f5j20m80dv0u5.jpg",
                width: 100,height: 100,
                key: UniqueKey(),
              ),
//              child: Text("吴东生"),

            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                child: Text("height"),
                onPressed: (){
                  setState(() {
                    size+=30;
                    if(size>300)size=100;
                  });
                },
              ),
              RaisedButton(
                child: Text("Radius"),
                onPressed: (){
                  setState(() {
                    radius+=30;
                    if(radius>=size)radius=0;
                  });
                },
              ),
            ],
          )
          
        ],

      )
       ;
  }
}
