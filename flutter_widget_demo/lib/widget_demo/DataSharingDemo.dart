import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataSharing with ChangeNotifier {

  int _msgCount = 0;

  int get msgCount => _msgCount;

  set msgCount (int msgCount) {
    _msgCount = msgCount;
    notifyListeners();
  }

}


class DataSharingDemo extends StatefulWidget {

  @override
  _DataSharingDemoState createState() => _DataSharingDemoState();
}

class _DataSharingDemoState extends State<DataSharingDemo> {

   DataSharing _dataSharing = DataSharing();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataSharing>(
      builder: (context) => _dataSharing,
      child: Scaffold(
        appBar: AppBar(
          title: Text('DataSharingDemo'),
          leading: IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                child: Consumer<DataSharing>(
                  builder: (context,dataSharing,child){
                    return Center(
                      child: Text('DataSharingDemo:数据共享的哦,你看这是${dataSharing.msgCount}啊!!'),
                    );
                  },
                ),
              ),
              SizedBox.fromSize(
                size: Size.fromHeight(44),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    height: 40,
                    width: 100,
                    color: Colors.green,
                    child: Text('点击更改数据'),
                  ),
                  onTap: (){
                    debugPrint('点击了更换数据');
                    _dataSharing.msgCount+=1;
                  },
                ),
              ),
              SecandPage(dataSharing: _dataSharing,),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    child: Text('跳转到第二个页面'),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

class SecandPage extends StatefulWidget {

  final DataSharing dataSharing;

  SecandPage({this.dataSharing});

  @override
  _SecandPageState createState() => _SecandPageState();
}

class _SecandPageState extends State<SecandPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataSharing>(
      builder: (context) => widget.dataSharing,
      child: Center(
        child: Consumer<DataSharing>(
          builder: (context,dataSharing,child){
            return Center(
              child: Text('SecandPage:数据共享的哦,你看这是${dataSharing.msgCount}啊!!'),
            );
          },
        ),
      ),
    );
  }
}

