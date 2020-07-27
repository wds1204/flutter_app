import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SecondeWidget();
  }
}
class SecondeWidget extends State<SecondePage>{

  int num=0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Scaffold(
      body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              RaisedButton(
                onPressed: () {
//                  Navigator.pop(context);
                  setState(() {
                    num++;
                  });
                },
                child: Text("增加+"),
              ),
              SizedBox(
                height: 40,
              ),
              MyCounterWidget("父组件的数据",num)
            ],
          ),
      ),

    ));
  }

}

class MyCounterWidget extends StatefulWidget {
  String message;
  int num;

  MyCounterWidget(this.message,this.num){
    print("1、调用MyCounterWidget的构造方法${num}");

  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    print("2、调用MyCounterWidget的createState方法");
    return _MyCounterState(this.num);
  }
  @override
  StatefulElement createElement() {
    // TODO: implement createElement
    return super.createElement();
  }
}

class _MyCounterState extends State<MyCounterWidget>{

  int counter = 0;


  _MyCounterState(this.counter){
    print("3、调用_MyCounterState的构造方法");
  }

  @override
  void initState() {
    // TODO: implement initState
    print("4、调用_MyCounterState的initState方法");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("调用didChangeDependencies=====>");
  }
  @override
  void didUpdateWidget(MyCounterWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    print("调用didUpdateWidget=====>${this.widget.num}");
    setState(() {
      counter=this.widget.num;
    });

  }
  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    print("reassemble");
  }
  @override
  Widget build(BuildContext context) {
    print("5、调用_MyCounterState的build方法");
    // TODO: implement build
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.redAccent,
                child: Text("+1"),
                onPressed: () {
                  setState(() {
                    counter++;
                  });
                },
              ),
              RaisedButton(
                color: Colors.orangeAccent,
                child: Text("-1"),
                onPressed: () {
                    setState(() {
                      counter--;
                    });
                },
              )
            ],
          ),
          Text("当前计数：$counter", style: TextStyle(fontSize: 30),),
          Text(this.widget.message,style: TextStyle(fontSize: 25,color: Colors.black38),)
        ],
      ),
    );
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("调用deactivate方法");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("6、调用State的dispose销毁方法");
  }

}
