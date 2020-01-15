import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class CustomizeTabBarDemo extends StatefulWidget {
  @override
  _CustomizeTabBarDemoState createState() => _CustomizeTabBarDemoState();
}

class _CustomizeTabBarDemoState extends State<CustomizeTabBarDemo> with SingleTickerProviderStateMixin {

  var _tabs = ['课程1','课程2','课程3','课程4','课程5','课程6','课程7','课程8','课程9','课程10'];

//  TabController _tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CustomizeTabBarDemo'),
      ),
      body: CustomizeTabBar(_tabs,44),
    );
  }
}


class CustomizeTabBar extends StatefulWidget {

  /// 标签数组
  final List<String> tabs;

  final double tabHeight;

  /// 构造方法
  CustomizeTabBar(List<String> tabs,double tabHeight) :
      this.tabs = tabs,
      this.tabHeight = tabHeight;

  /// 更新下标
  void changeIndex(int index) {

  }



  @override
  _CustomizeTabBarState createState() => _CustomizeTabBarState();
}

class _CustomizeTabBarState extends State<CustomizeTabBar> {

  /// 当前下标
  var currentIndex = 0;

  /// int型Subject
  BehaviorSubject<int> _currentIndexSubject;

  /// 获取Stream，用于读取index的值
  Stream<int> get indexStream => _currentIndexSubject.stream;

  /// 获取Sink，用于更新index的值并重新build
  Sink<int> get indexSink => _currentIndexSubject.sink;


  /// 使用GlobalKey 来获取当前选中控件的size
  List<GlobalKey> _globalKeys;

  /// 分页控制器
  PageController _pageController;

  /// 滚动控制器
  ScrollController _scrollController;

  /// build完成
  bool _isFinishBuild;

  /// 获取tabar
  Widget getTabBar(){
    final _tabs = widget.tabs;
    _globalKeys = _globalKeys??_tabs.map((title){
      return GlobalKey();
    }).toList();
    return Stack(
      children: <Widget>[
        /// 底部TabBar布局
        Container(
          color: Colors.green,
          height: widget.tabHeight,
          child: SingleChildScrollView(
            physics: null,
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            /// 通过将tabs转为map方式（下标作为key，原先数组元素作为value），再遍历keys得到index
            child: StreamBuilder(
              stream: indexStream,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  return Row(
                    children: _tabs.asMap().keys.map((index) {
                      TextStyle style = snapshot.data == index ? TextStyle(color: Colors.black54,fontSize: 17) : TextStyle(color: Colors.yellow,fontSize: 15);
                      return GestureDetector(
                        key: _globalKeys[index],
                        child: Padding(
                          padding: EdgeInsets.only(left: 18),
                          child: Text(_tabs[index],style: style,),
                        ),
                        onTap: (){
                          currentIndex = index;
                          indexSink.add(index);
                          _pageController.jumpToPage(index);
                        },
                      );}).toList(),
                  );
                }
                return Container();
              },
            )
          ),
        ),

//        StreamBuilder(
//          stream: indexStream,
//          builder: (BuildContext context, AsyncSnapshot<int> snapshot){
//            if (snapshot.connectionState == ConnectionState.active) {
//
//
//              double left = 18;
//              if (_isFinishBuild){
//                /// 获取当前tab对应的globalkey的RenderBox
//                RenderBox renderBox = _globalKeys[snapshot.data].currentContext.findRenderObject();
//
//                /// 获取当前tab的size
//                Size size = renderBox.size;
//
//                /// 获取当前tab的Offset
//                Offset offset = renderBox.localToGlobal(Offset.zero);
//
//                left = offset.dx+size.width*0.5-9;
//              }
//              return LayoutBuilder(
//                builder: (BuildContext context, BoxConstraints constraints){
//                  debugPrint('最大宽度：${constraints.maxWidth}；最大高度：${constraints.maxHeight}');
//                  return Padding(
//                    padding: EdgeInsets.only(top: 40,left: left),
//                    child: Container(
//                      color: Colors.white,
//                      height: 3,
//                      width: 18,
//                    ),
//                  );
//                },
//              );
//            }
//            return Container();
//          },
//        )
      ],
    );
  }

  void buildComplete(Duration duration){
    _isFinishBuild = true;
    debugPrint('--------------------------build完成啦！！');
  }

  /// 更新TabBar布局
  void updateTabBarOffset(int index) {

    /// 获取当前tab对应的globalkey的RenderBox
    RenderBox renderBox = _globalKeys[index].currentContext.findRenderObject();

    /// 获取当前tab的size
    Size size = renderBox.size;

    /// 获取当前tab的Offset
    Offset offset = renderBox.localToGlobal(Offset.zero);

    /// 获取屏幕宽度
    final screenWidth = MediaQuery.of(context).size.width;

    debugPrint('--------------------当前的下标：$index; 偏移量： ${offset.dx},maxX：${offset.dx + size.width}');

    /// 获取最后一个tab的位置信息
    RenderBox lastRenderBox = _globalKeys.last.currentContext.findRenderObject();
    Size lastSize = lastRenderBox.size;
    Offset lastOffset = lastRenderBox.localToGlobal(Offset.zero);
    double contentWidth = lastOffset.dx + lastSize.width;

    /// offset为0或者
    if (_scrollController.offset != 0 || _scrollController.offset <= (offset.dx + size.width - screenWidth)) {
      double dx = offset.dx + size.width - screenWidth + 10;
      if (dx < 0) {
        dx = 0;
      }


      debugPrint('--------------------最后一个：${_globalKeys.length-1}; 偏移量： ${lastOffset.dx},maxX：${lastOffset.dx + lastSize.width}');
//      if (dx >= contentWidth-screenWidth) {
//        dx = contentWidth-screenWidth;
//      }
      _scrollController.animateTo(dx, duration: Duration(milliseconds: 500), curve: Curves.ease);
    }
  }

  @override
  void initState() {
    super.initState();
    /// 初始化流
    _currentIndexSubject = BehaviorSubject<int>.seeded(currentIndex);
    _currentIndexSubject.listen((index){
      /// 更新tabbar偏移量
      updateTabBarOffset(index);
    });

    /// 初始化分页控制器
    _pageController = PageController(initialPage: currentIndex);

    /// 初始化滚动控制器
    _scrollController = ScrollController(keepScrollOffset: false);
    _scrollController.addListener((){
      debugPrint('滚动偏移量：${_scrollController.offset}');
    });

    /// 监听Widget是否绘制完毕
    WidgetsBinding.instance.addPostFrameCallback(buildComplete);
  }

  @override
  void dispose() {
    super.dispose();
    /// 关闭流
    _currentIndexSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    final _tabs = widget.tabs;
    return Scaffold(
      body: Column(
        children: <Widget>[
          getTabBar(),
          Expanded(
            child: PageView(
              /// 页面切换
              onPageChanged: (index){

                /// 更新下标
                currentIndex = index;

                /// 发送流重新rebuild子widget
                indexSink.add(index);

              },
              controller: _pageController,
              children: _tabs.map((title){
                return Center(
                  child: Text(title),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

