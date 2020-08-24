# flutterapp

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


### 什么是Key

可以使用Key来控制框架将在widget重建时与哪些其他widget匹配。默认情况下，框架根据他们的runtimeType和它们的显示顺序来匹配。
使用Key时，框架要求两个widget具有相同的Key和runtimeType。



关于key我们来看看下面这个例子。
```dart
class StatelessContainer extends StatelessWidget {
  final Color color = RandomColor().randomColor();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: color,
    );
  }
}
```
复制代码这是一个很简单的 Stateless Widget，显示在界面上的就是一个 100 * 100 的有颜色的 Container。
RandomColor 能够为这个 Widget 初始化一个随机颜色。
我们现在将这个Widget展示到界面上。
```dart
class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  List<Widget> widgets = [
    StatelessContainer(),
    StatelessContainer(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgets,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: switchWidget,
        child: Icon(Icons.undo),
      ),
    );
  }

  switchWidget(){
    widgets.insert(0, widgets.removeAt(1));
    setState(() {});
  }
}
```
复制代码这里在屏幕中心展示了两个 StatelessContainer 小部件，当我们点击 floatingActionButton 时，将会执行 switchWidget 并交换它们的顺序。



看上去并没有什么问题，交换操作被正确执行了。现在我们做一点小小的改动，将这个 StatelessContainer 升级为 StatefulContainer。
```dart
class StatefulContainer extends StatefulWidget {
  StatefulContainer({Key key}) : super(key: key);
  @override
  _StatefulContainerState createState() => _StatefulContainerState();
}

class _StatefulContainerState extends State<StatefulContainer> {
  final Color color = RandomColor().randomColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: color,
    );
  }
}
```
复制代码在 StatefulContainer 中，我们将定义 Color 和 build 方法都放进了 State 中。
现在我们还是使用刚才一样的布局，只不过把 StatelessContainer 替换成 StatefulContainer，看看会发生什么。

这时，无论我们怎样点击，都再也没有办法交换这两个Container的顺序了，而 switchWidget 确实是被执行了的。
为了解决这个问题，我们在两个 Widget 构造的时候给它传入一个 UniqueKey。
```dart
class _ScreenState extends State<Screen> {
  List<Widget> widgets = [
    StatefulContainer(key: UniqueKey(),),
    StatefulContainer(key: UniqueKey(),),
  ];
}
  
```
复制代码然后这两个 Widget 又可以正常被交换顺序了。
看到这里大家肯定心中会有疑问，为什么 Stateful Widget 无法正常交换顺序，加上了 Key 之后就可以了，在这之中到底发生了什么？ 为了弄明白这个问题，我们将涉及 Widget 的 diff 更新机制。


Widget中的源码：

```dart
@immutable
abstract class Widget extends DiagnosticableTree {
  const Widget({ this.key });
  final Key key;
  //···
  
  /// Whether the `newWidget` can be used to update an [Element] that currently
  /// has the `oldWidget` as its configuration.
  ///
  /// An element that uses a given widget as its configuration can be updated to
  /// use another widget as its configuration if, and only if, the two widgets
  /// have [runtimeType] and [key] properties that are [operator==].
  ///
  /// If the widgets have no key (their key is null), then they are considered a
  /// match if they have the same type, even if their children are completely
  /// different.
  /// 
  static bool canUpdate(Widget oldWidget, Widget newWidget) {
    return oldWidget.runtimeType == newWidget.runtimeType
        && oldWidget.key == newWidget.key;
  }
}
```

我们知道widget只是一个配置且无法修改，而Element才是真正被使用的对象，并可以修改。当新的Widget到来时将会调用canUpdate方法，来确定这个Element是否需要更新。

*canUpdate* 对两个（新老） Widget 的 runtimeType 和 key 进行比较，从而判断出当前的 Element 是否需要更新 
                      

* StatelessContainer比较过程




















