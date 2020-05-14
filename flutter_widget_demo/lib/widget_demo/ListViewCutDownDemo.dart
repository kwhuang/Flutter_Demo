import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_widget_demo/util/date_convert_util.dart';


class CutDownEntity {

  /// 开始时间戳
  int startTime;
  /// 结束时间戳
  int endTime;

  CutDownEntity({
    this.startTime,
    this.endTime
  });
}

class ListViewCutDownDemo extends StatefulWidget {
  @override
  _ListViewCutDownDemoState createState() => _ListViewCutDownDemoState();
}

class _ListViewCutDownDemoState extends State<ListViewCutDownDemo> {

  List<CutDownEntity> datas = [
    CutDownEntity(startTime: 1589431636000,endTime: 1589438836000),
    CutDownEntity(startTime: 1589438836000,endTime: 1589442436000),
    CutDownEntity(startTime: 1589442436000,endTime: 1589446036000),
    CutDownEntity(startTime: 1589431636000,endTime: 1589438836000),
    CutDownEntity(startTime: 1589438836000,endTime: 1589442436000),
    CutDownEntity(startTime: 1589442436000,endTime: 1589446036000),
    CutDownEntity(startTime: 1589431636000,endTime: 1589438836000),
    CutDownEntity(startTime: 1589438836000,endTime: 1589442436000),
    CutDownEntity(startTime: 1589442436000,endTime: 1589446036000),
    CutDownEntity(startTime: 1589442436000,endTime: 1589438836000),
    CutDownEntity(startTime: 1589438836000,endTime: 1589442436000),
    CutDownEntity(startTime: 1589442436000,endTime: 1589446036000)
  ];

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('ListViewCutDownDemo'),
        ),
        body: ListView.builder(
            itemCount: datas.length,
            itemBuilder: (context,index){
              return TodayStudyCard(cutDownEntity: datas[index],
              );}),
      );
  }
}


class TodayStudyCard extends StatefulWidget {

  final CutDownEntity cutDownEntity;

  TodayStudyCard({Key key, this.cutDownEntity}) : super(key:key);

  @override
  _TodayStudyCardState createState() => _TodayStudyCardState();
}

class _TodayStudyCardState extends State<TodayStudyCard> {

  /// 状态
  String _currentStatus;

  /// 是否需要倒计时
  bool _needCutDown = false;

  /// 倒计时时间
  int _cutDownTime = 0;

  /// 定时器
  Timer _countdownTimer;

  /// 根据开始时间、结束时间判断直播状态
  String getLiveStatus(int startTime, int endTime) {

    /// 当前时间，毫秒
    int currentTime = DateConvertUtil.getNowDateMilliseconds();

    /// 与当前时间比较，判断是否开始
    if (currentTime - startTime > 0) {
      _needCutDown = false;
      /// 已经开始 使用结束时间判断直播是否结束
      if (endTime - currentTime > 0) {
        return '直播中';
      } else {
        return '直播已结束';
      }
    } else {
      /// 即将开始，当时间是当天时，需要显示倒计时 "离上课还有 hh:mm:ss"

      /// 倒计时时间
      _cutDownTime = startTime-currentTime;
      _needCutDown = true;
      return '未开始';
    }
  }

  void startTimer() {
    setState(() {
      if (_countdownTimer != null) {
        return;
      }
      // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
      _countdownTimer =
      new Timer.periodic(new Duration(seconds: 1), (timer) {
        setState(() {
          if (_cutDownTime > 0) {
            _cutDownTime-=1000;
          } else {
            _countdownTimer.cancel();
            _countdownTimer = null;
          }
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _currentStatus = getLiveStatus(widget.cutDownEntity.startTime, widget.cutDownEntity.endTime);
    if(_needCutDown) {
      startTimer();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.black,
            child: Text(_currentStatus,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red),),
          ),
          Align(
            alignment: Alignment.center,
            child: Visibility(
              visible: _needCutDown,
              child: Container(
                alignment: Alignment.center,
                height: 30,
                width: 150,
                color: Colors.yellow,
                child: Text('离上课还有 ${DateConvertUtil.getDateStrByMillisecond(_cutDownTime,format: DateFormat.HOUR_MINUTE_SECOND)}'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 2,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }

  // 不要忘记在这里释放掉Timer
  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    debugPrint('销毁了');
    super.dispose();
  }
}
