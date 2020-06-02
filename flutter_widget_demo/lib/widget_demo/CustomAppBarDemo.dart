
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_demo/custom_widget/customer_appbar.dart';
import 'package:flutter_widget_demo/custom_widget/appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBarDemo extends StatefulWidget {
  @override
  _CustomAppBarDemoState createState() => _CustomAppBarDemoState();
}

class _CustomAppBarDemoState extends State<CustomAppBarDemo> {

  Future<bool> checkIsInstallBaiduMap() async {
    String url = 'baidumap://';
    bool isInstall = await canLaunch(url);
    debugPrint('${!isInstall ? '没有安装' : '安装了'}百度地图');
    return isInstall;
  }

  @override
  Widget build(BuildContext context) {
    checkIsInstallBaiduMap();
    return Scaffold(
      appBar: BaseViewBar(
          childView: new BaseTitleBar(
            "首页",
            leftIcon: Icons.arrow_back_ios,
            rightText: "提交",
            rightClick: () {
              print("点击了干嘛啊。。。哦");
            },
          ),
          preferredSize: Size.fromHeight(50.0)
      ),
      body: SafeArea(
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          color: Colors.yellow,
          child:RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,

            text: TextSpan(
              text: 'PageStorageKey继承自ValueKey，其实就是一个Key，保存状态用的。PageStorageKey：它是定义PageStorage的value将保存在何处的一个ValueKey。Scrollable（实际上是ScrollPosition）以及它的相关类使用PageStorage保存滚动偏移量。每次滚动完成时，滚动条的页面存储都会更新。',
              style: TextStyle(color: Colors.black38),
              children: [
                TextSpan(
                  text: '查看 >',
                  style: TextStyle(color: Colors.blue),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}
