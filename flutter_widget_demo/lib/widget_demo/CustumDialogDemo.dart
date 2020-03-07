import 'dart:async';

import 'package:flutter/material.dart';


class CustumDialogDemo extends Dialog {


  String text;

  CustumDialogDemo({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Timer timer = new Timer(new Duration(seconds: 5), () {
      // 只在倒计时结束时回调
      Navigator.pop(context);
    });

    // TODO: implement build
    return Material( //创建透明层
      type: MaterialType.transparency, //透明类型
      child: new Center( //保证控件居中效果
        child: new SizedBox(
          width: 120.0,
          height: 120.0,
          child: new Container(
            decoration: ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new CircularProgressIndicator(),
                new Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: new Text(
                    text,
                    style: new TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
