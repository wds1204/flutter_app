//import 'package:flutter/material.dart';
//import 'dart:async';
//void main() {
//  runApp(MyApp());
//}
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or simply save your changes to "hot reload" in a Flutter IDE).
//        // Notice that the counter didn't reset back to zero; the application
//        // is not restarted.
//        primarySwatch: Colors.blue,
//        // This makes the visual density adapt to the platform that you run
//        // the app on. For desktop platforms, the controls will be smaller and
//        // closer together (more dense) than on mobile platforms.
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  // This widget is the home page of your application. It is stateful, meaning
//  // that it has a State object (defined below) that contains fields that affect
//  // how it looks.
//
//  // This class is the configuration for the state. It holds the values (in this
//  // case the title) provided by the parent (in this case the App widget) and
//  // used by the build method of the State. Fields in a Widget subclass are
//  // always marked "final".
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // This method is rerun every time setState is called, for instance as done
//    // by the _incrementCounter method above.
//    //
//    // The Flutter framework has been optimized to make rerunning build methods
//    // fast, so that you can just rebuild anything that needs updating rather
//    // than having to individually change instances of widgets.
//    return Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),
//      body: Center(
//        // Center is a layout widget. It takes a single child and positions it
//        // in the middle of the parent.
//        child: Column(
//          // Column is also a layout widget. It takes a list of children and
//          // arranges them vertically. By default, it sizes itself to fit its
//          // children horizontally, and tries to be as tall as its parent.
//          //
//          // Invoke "debug painting" (press "p" in the console, choose the
//          // "Toggle Debug Paint" action from the Flutter Inspector in Android
//          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//          // to see the wireframe for each widget.
//          //
//          // Column has various properties to control how it sizes itself and
//          // how it positions its children. Here we use mainAxisAlignment to
//          // center the children vertically; the main axis here is the vertical
//          // axis because Columns are vertical (the cross axis would be
//          // horizontal).
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'try test,You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.headline4,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'BreathePage.dart';
import 'ThirdPage.dart';
import 'TranstionPage.dart';
import 'secondePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(routes: <String, WidgetBuilder>{
      '/': (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("first Screen"),
          ),
          body: HomeContent(),
        );
      },
      '/second': (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Second Screen"),
          ),
          body: SecondePage(),
        );
      },
      '/third':(context){
        return Scaffold(
          appBar: AppBar(
            title: Text("third Screen"),
          ),
          body: ThirdPage(),
        );
      },
      '/transtion':(context){
        return Scaffold(
          appBar: AppBar(
            title: Text("显示动画 Screen"),
          ),
          body: TranstionPage(),
        );
      },
      '/breathe':(context){
        return Scaffold(
          appBar: AppBar(
            title: Text("4-7-8呼吸法")
          ),
          body: BreathePage(),
        );
      }
    });
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            ProductItem(1,"数字反转计数器", "Macbook Product1",
                "https://tva1.sinaimg.cn/large/006y8mN6gy1g72j6nk1d4j30u00k0n0j.jpg"),
            ProductItem(2,"animation练习", "Macbook Product2",
                "https://tva1.sinaimg.cn/large/006y8mN6gy1g72imm9u5zj30u00k0adf.jpg"),
            ProductItem(3,"transtion使用", "Macbook Product3",
                "https://tva1.sinaimg.cn/large/006y8mN6gy1g72imqlouhj30u00k00v0.jpg"),
            ProductItem(4,"4-7-8呼吸法", "Macbook Product3",
                "https://tva1.sinaimg.cn/large/006y8mN6gy1g72imqlouhj30u00k00v0.jpg"),
          ],
        ));
  }
}

class ProductItem extends StatelessWidget {
  final String title;
  final String desc;
  final String imgs;
  final int index;
  BuildContext context;

 final style1= TextStyle(fontSize: 24);
 final style2= TextStyle(fontSize: 18);

  void handleTap(BuildContext context) {
    print("handleTap");
    switch(this.index){
      case 1:
        Navigator.pushNamed(context, "/second");
        break;
      case 2:
        Navigator.pushNamed(context, "/third");
        break;
      case 3:
        Navigator.pushNamed(context, "/transtion");
        break;
      case 4:
        Navigator.pushNamed(context, "/breathe");
        break;
    }
  }

  ProductItem(this.index,this.title, this.desc, this.imgs);

  @override
  Widget build(BuildContext context) {
    context = context;
    // TODO: implement build
    return GestureDetector(
        onTap: () {
          handleTap(context);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(color: Colors.white,border:Border.all(color: Colors.black12,width: 2) ),
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: style1,),
                    Text(desc, style: style2,),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Image.network(imgs),
            ],
          ),
        ));
  }
}
