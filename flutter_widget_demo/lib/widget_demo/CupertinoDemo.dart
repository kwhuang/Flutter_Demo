
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoDemo extends StatefulWidget {
  @override
  _CupertinoDemoState createState() => _CupertinoDemoState();
}

class _CupertinoDemoState extends State<CupertinoDemo> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(

        leading: IconButton(
          icon:Icon(Icons.arrow_left),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        middle: Text('CustomAppBar',style: TextStyle(color: Colors.blue),),
        automaticallyImplyMiddle: true,
        trailing: Row(
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
      ),
      child: Center(
        child: Text('CupertinoNavigationBar'),
      ),
    );
  }
}
