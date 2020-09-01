import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DragUpDemoPage extends StatefulWidget {
  @override
  _DragUpDemoPageState createState() => _DragUpDemoPageState();
}

class _DragUpDemoPageState extends State<DragUpDemoPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("SlidingUpPanelExample"),
      ),
      body: SlidingUpPanel(
        backdropColor: Colors.black26,
        backdropEnabled: true,
        maxHeight: screenSize.height-150,
        minHeight: screenSize.height/3.0*2.0,
        borderRadius:BorderRadius.circular(24),
        panel: Center(
          child: Text("这里是抽屉区"),
        ),
        body: Center(
          child: Text("这么是页面区"),
        ),
      ),
    );
  }
}
