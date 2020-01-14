import 'dart:async';

import 'package:flutter/material.dart';


//  StreamController单流广播流控制器，使用BehaviorSubject（需要导入rxdart依赖）也可以使用
class StreamControllerDemo extends StatefulWidget {
  @override
  _StreamControllerDemoState createState() => _StreamControllerDemoState();
}

class _StreamControllerDemoState extends State<StreamControllerDemo> {
  int index = 0;

  // int类型的StreamController，使用此方式控制可以对单独租价进行刷新操作，不用依赖setState来刷新整个页面
  final StreamController<int> _streamController = StreamController(onListen: (){
    debugPrint('Stream变化');
  });

  // 获取Stream，用于读取index的值
  Stream<int> get indexStream => _streamController.stream;

  // 获取Sink，用于更新index的值并重新build
  Sink<int> get indexSink => _streamController.sink;



  @override
  void initState() {

    //将单订阅流转化为广播流,才能添加多个监听，例如下方的StreamSubscription、StreamBuilder监听
    // Stream stream = _streamController.stream.asBroadcastStream();
    // 初始化一个监听
    // final StreamSubscription subscription = ctrl.stream.listen((data) => print('$data'));

    // 首次build布局
    indexSink.add(index);
    super.initState();
  }

  @override
  void dispose() {
    // 不用时，需要手动关闭
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StreamControllerDemo'),
      ),
      body: Center(
          child: StreamBuilder(
            // 设置Stream监听
            stream: indexStream,
            // 监听到变化后的布局更新操作
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                return Text('下标 + ${snapshot.data}');
              }
              return Container();
            },
          ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('+'),
        onPressed: () {
          indexSink.add(++index);
        },
      ),
    );
  }
}
