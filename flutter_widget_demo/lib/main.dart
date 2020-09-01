import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_demo/widget_demo/DragUpDemoPage.dart';
import 'widget_demo/DefaultTabController.dart';
import 'widget_demo/SingleChildScrollView.dart';
import 'widget_demo/StreamController.dart';
import 'widget_demo/CustermerTabBarDemo.dart';
import 'widget_demo/OverlayState+OverlayEntry.dart';
import 'widget_demo/sharedPreferences.dart';
import 'widget_demo/TranstionPushDemo.dart';
import 'widget_demo/CustumDialogDemo.dart';
import 'widget_demo/CustomAppBarDemo.dart';
import 'widget_demo/CupertinoDemo.dart';
import 'widget_demo/ListViewCutDownDemo.dart';
import 'widget_demo/DataSharingDemo.dart';
import 'widget_demo/CustomPaintorDemo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {


  int _currentIndex = 0;
  final List<Widget> _children = [
    ListDemo(),
    OverlayEntryAndOverlayEntry(),
    CustomAppBarDemo(),
    CupertinoDemo(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children[_currentIndex],
      // CupertinoTabBar 是IOS分格
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
              title: new Text("首页"),
              icon: Icon(Icons.message),
          ),
          BottomNavigationBarItem(
              title: new Text("课程"),
              icon: Icon(Icons.message),
          ),
          BottomNavigationBarItem(
              title: new Text("学习"),
              icon: Icon(Icons.message),
          ),
          BottomNavigationBarItem(
              title: new Text("我的"),
              icon: Icon(Icons.message),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

}

class ListDemo extends StatelessWidget {

  final _lists = <String>[
    'DefaultTabController+NestedScrollView',
    'SingleChildScrollviewDemo',
    'StreamControllerDemo',
    'CustomizeTabBarDemo',
    'OverlayEntryAndOverlayEntry',
    'SharePreferences',
    'TranstionPushDemo',
    'CustumDialogDemo',
    'ListViewCutDownDemo',
    'DataSharingDemo',
    'CustomPaintorDemo',
    'DragUpDemoPage'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WidgetDemo'),
      ),
      body: ListView.builder(
          itemCount: _lists.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: ListTile(title: Text(_lists[index])),
              onTap: () {
                if (index == 0) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (BuildContext context) {
                    return DefaultTabControllerDemo();
                  }));
                } else if (index == 1) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (BuildContext context) {
                    return SingleChildScrollviewDemo();
                  }));
                } else if (index == 2) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (BuildContext context) {
                    return StreamControllerDemo();
                  }));
                } else if (index == 3) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (BuildContext context) {
                    return CustomizeTabBarDemo();
                  }));
                } else if (index == 4) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (BuildContext context) {
                    return OverlayEntryAndOverlayEntry();
                  }));
                } else if (index == 5) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (BuildContext context) {
                    return SharePreferences();
                  }));
                } else if (index == 6) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (BuildContext context) {
                    return TranstionPushDemo();
                  }));
                } else if (index == 7) {

                  showDialog<Null>(
                      context: context, //BuildContext对象
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return CustumDialogDemo(text :'提示框');
                      });
                }else if (index == 8) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (BuildContext context) {
                    return ListViewCutDownDemo();
                  }));
                }else if (index == 9) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (BuildContext context) {
                    return DataSharingDemo();
                  }));
                } else if (index == 10 ) {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return PainterDemo();
                }));
                }else if (index == 11 ) {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return DragUpDemoPage();
                  }));
                }

              },
            );
          }
      ),
    );
  }
}
