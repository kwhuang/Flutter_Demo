import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Overlay类似获取屏幕window，可以使用此类插入OverlayEntry方式实现累屎Toast、弹窗的效果
/// 使用：
/// 1、创建一个OverlayEntry类实例
/// 2、获取Overlay实例调用insert方法添加OverlayEntry类实例
/// 3、不使用时需要将OverlayEntry类实例移除，调用该实例的remove方法来移除OverlayEntry实例
class OverlayEntryAndOverlayEntry extends StatefulWidget {
  @override
  _OverlayEntryAndOverlayEntryState createState() => _OverlayEntryAndOverlayEntryState();
}

class _OverlayEntryAndOverlayEntryState extends State<OverlayEntryAndOverlayEntry> {

  /// 通过bool值来判断是否显示Offstage的child
  bool offstage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OverlayEntryAndOverlayEntry'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            right: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_upward),
              onPressed: (){
                Toast.show(context: context, message: 'Toast 内容');

              },
            ),
          ),
          Center(
            child: Text('OverlayEntryAndOverlayEntry'),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                new Offstage(
                  offstage: offstage,
                  child: Container(
                    height: 300,
                    width: 300,
                    color: Colors.red,
                    child: Text('OverlayEntry'),
                    ),
                  ),
                CupertinoButton(
                  child: Text("点击切换显示"),
                  onPressed: () {
                    setState(() {
                      offstage = !offstage;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Toast {
  static void show({@required BuildContext context, @required String message}) {
    /// 创建一个OverlayEntry对象
    OverlayEntry overlayEntry = new OverlayEntry(builder: (context) {
      /// 外层使用Positioned进行定位，控制在Overlay中的位置
      return new Positioned(
          top: MediaQuery.of(context).size.height * 0.2,
          child: Container(
            color: Colors.blueGrey,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: new Center(
              child: new Card(
                child: new Padding(
                  padding: EdgeInsets.all(8),
                  child: new Text(message),
                ),
                color: Colors.grey,
              ),
            ),
          )
      );
    });

    /// 往Overlay中插入插入OverlayEntry
    Overlay.of(context).insert(overlayEntry);

    /// 两秒后，移除Toast
    new Future.delayed(Duration(seconds: 2)).then((value) {
      overlayEntry.remove();
    });
  }
}
