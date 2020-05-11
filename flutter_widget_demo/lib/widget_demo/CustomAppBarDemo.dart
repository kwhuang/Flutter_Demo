
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_demo/custom_widget/customer_appbar.dart';

class CustomAppBarDemo extends StatefulWidget {
  @override
  _CustomAppBarDemoState createState() => _CustomAppBarDemoState();
}

class _CustomAppBarDemoState extends State<CustomAppBarDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleEdgeInsets: EdgeInsets.only(left: 5,right: 5),
        left: IconButton(
          icon:Icon(Icons.arrow_left),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        right: Row(
          children: <Widget>[
            IconButton(
              icon:Icon(Icons.arrow_left),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon:Icon(Icons.arrow_left),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
        title: Text('CustomAppBarDemo',overflow: TextOverflow.ellipsis,maxLines: 1,textAlign: TextAlign.center,),
        backgroundColor: Colors.white,
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
