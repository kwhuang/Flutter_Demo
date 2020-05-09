
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
        title: Text('CustomAppBarDemonnuoononoinoinoinoinoinoinoinofsafasfasfasdinonono',overflow: TextOverflow.ellipsis,maxLines: 1,textAlign: TextAlign.center,),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Center(
          child: Text('自定义appbar'),
        ),
      ),
    );
  }
}
