import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {

  CustomAppBar({
    Key key,
    this.title,
    this.titleEdgeInsets = EdgeInsets.zero,
    this.appBarHeight = 44,
    this.left,
    this.right,
    this.backgroundColor = Colors.white,
    this.underlineColor = Colors.black38,
    this.underlineHeight = 0.5
  }) : super(key : key);

  /// Expend标题
  final Widget title;

  /// 标题内边距 默认EdgeInsets.zero
  final EdgeInsets titleEdgeInsets;

  /// 导航高度 默认44
  final double appBarHeight;

  /// 导航左边Widget
  final Widget left;

  /// 导航右边Widget
  final Widget right;

  ///导航栏状态栏颜色 默认Colors.white
  final Color backgroundColor;

  ///导航下划线颜色 默认Colors.black38
  final Color underlineColor;

  ///下划线高度 默认0.5
  final double underlineHeight;


  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {

  Widget leftWidget() {
    if (widget.left != null) {
      return LayoutId(
        id: _CustomAppBarLayoutDelegate.leftID,
        child: Container(
//            padding: const EdgeInsets.only(left: 5),
            child: widget.left,
          ),
      );
    }
    return Container();
  }

  Widget titleWidget() {
    if (widget.title != null) {
      return LayoutId(
        id: _CustomAppBarLayoutDelegate.titleID,
        child: Container(
          padding: widget.titleEdgeInsets,
          child: Center(
            child: widget.title,
          ),
        ),
      );
    }
    return Container();
  }

  Widget rightWidget() {
    if (widget.right != null) {
      return LayoutId(
        id: _CustomAppBarLayoutDelegate.rightID,
        child: Container(
//          padding: const EdgeInsets.only(right: 5),
          child: widget.right,
        ),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: widget.backgroundColor,
      child: SafeArea(
        top: true,
        child: Container(
            decoration: UnderlineTabIndicator(
              borderSide: BorderSide(width: widget.underlineHeight, color: widget.underlineColor),
            ),
            height: widget.appBarHeight,
            width: MediaQuery.of(context).size.width,
            child: CustomMultiChildLayout(
              delegate: _CustomAppBarLayoutDelegate(),
              children: <Widget>[
                leftWidget(),
                titleWidget(),
                rightWidget()
              ],
            )
        ),
      ),
    );
  }

//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      color: widget.backgroundColor,
//      child: SafeArea(
//        top: true,
//        child: Container(
//            decoration: UnderlineTabIndicator(
//              borderSide: BorderSide(width: widget.underlineHeight, color: widget.underlineColor),
//            ),
//            height: widget.appBarHeight,
//            child: Row(
//              children: <Widget>[
//                leftWidget(),
//                titleWidget(),
//                rightWidget()
//              ],
//            )
//        ),
//      ),
//    );
//  }
}

class _CustomAppBarLayoutDelegate extends MultiChildLayoutDelegate {
  static const String leftID = 'custom_appbar_left';
  static const String titleID = 'custom_appbar_title';
  static const String rightID = 'custom_appbar_right';

  ///自定义布局
  @override
  void performLayout(Size size) {

    debugPrint('宽度:${size.width}；高度:${size.height}');
    /// 获取当前BoxConstraints
    final BoxConstraints constraints = BoxConstraints(maxWidth: size.width);

    /// 重新设置大小
    final Size leftSize = layoutChild(leftID, BoxConstraints.loose(Size(44, 44)));
    final Size titleSize = layoutChild(titleID, BoxConstraints.loose(Size(size.width-88*2,44)));
    final Size rightSize = layoutChild(rightID, BoxConstraints.loose(Size(96, 44)));

    debugPrint('left------宽度:${leftSize.width}；高度:${leftSize.height}');
    debugPrint('title------宽度:${titleSize.width}；高度:${titleSize.height}');
    debugPrint('right------宽度:${rightSize.width}；高度:${rightSize.height}');

    /// 重新设置位置
    positionChild(leftID, Offset(0.0, 0.0));
    final double titleX = leftSize.width > rightSize.width ? leftSize.width : rightSize.width;
    positionChild(titleID, Offset(titleX, size.height/2 - titleSize.height/2));
    positionChild(rightID, Offset(size.width-rightSize.width,0));

  }

  ///是否需要重新布局
  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}
