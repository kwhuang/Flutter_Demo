import 'package:flutter/material.dart';

///  SingleChildScrollView 类似app中的scrollview，只要添加内容超过屏幕可视范围就可以滚动
class SingleChildScrollviewDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SingleChildScrollView'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      debugPrint('点击了黄色');
                    },
                    child: Container(
                      // A fixed-height child.
                      color: const Color(0xff808000), // Yellow
                      height: 120.0,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('这是标题哦',style: TextStyle(fontSize: 15,color: Colors.white),),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      debugPrint('点击了绿色');
                    },
                    child: Container(
                      // Another fixed-height child.
                      color: const Color(0xff008000), // Green
                      height: 120.0,
                    ),
                  ),

                  Container(
                    // A fixed-height child.
                    color: const Color(0xff808000), // Yellow
                    height: 120.0,
                  ),
                  Container(
                    // Another fixed-height child.
                    color: const Color(0xff008000), // Green
                    height: 120.0,
                  ),
                  Container(
                    // A fixed-height child.
                    color: const Color(0xff808000), // Yellow
                    height: 120.0,
                  ),
                  Container(
                    // Another fixed-height child.
                    color: const Color(0xff008000), // Green
                    height: 120.0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}