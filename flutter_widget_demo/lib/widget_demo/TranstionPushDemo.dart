import 'package:flutter/material.dart';

class TranstionPushDemo extends StatefulWidget {
  @override
  _TranstionPushDemoState createState() => _TranstionPushDemoState();
}

class _TranstionPushDemoState extends State<TranstionPushDemo> {

  Route _createRoute() {
    return PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 250),
        // 需要跳转的页面
        pageBuilder: (context, animation, secondaryAnimation) => PresentPage(),
        // 设置切换动画方式，默认是左右切换
        transitionsBuilder:(context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset(0.0, 0.0);
          var tween = Tween(begin: begin, end: end);
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TranstionPushDemo'),

      ),
      body: Center(
        child: Container(
          child: RaisedButton(
            child: Text('present to PresentPage'),
            onPressed: (){
              Navigator.push(context, _createRoute());
            },
          ),
        ),
      ),
    );
  }
}

class PresentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PresnetPage'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
        body: Center(
          child: Text('PresentPage'),
        ),
    );
  }
}

