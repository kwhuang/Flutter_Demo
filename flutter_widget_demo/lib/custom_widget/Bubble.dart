import 'package:flutter/material.dart';

const _ArrowTop = 6.0;      //箭头距离顶部位置
const _ArrowWidth = 7.0;    //箭头宽度
const _ArrowHeight = 10.0;  //箭头高度
const _MinHeight = 32.0;    //内容最小高度
const _MinWidth = 50.0;     //内容最小宽度

class Bubble extends StatelessWidget {

  /// 箭头方向：左/右
  final BubbleDirection direction;
  /// 气泡圆角
  final Radius borderRadius;
  /// 子widget，当使用row，column等视图作为子widget时需要设置对应的宽高
  final Widget child;
  /// 背景色
  final Color color;
  /// 气泡外边距
  final EdgeInsetsGeometry padding;
  /// 内边距
  final EdgeInsetsGeometry margin;
  /// 气泡大小约束
  final BoxConstraints constraints;
  /// 气泡
  final double width;
  /// 气泡高度
  final double height;
  /// 子widget对齐方式
  final Alignment alignment;

  /// 内容左右边距
  final _left;
  final _right;

  /// 常量构造方法
  const Bubble(
      {Key key,
        this.direction = BubbleDirection.left,
        this.borderRadius,
        this.child, this.color, this.padding, this.margin, this.constraints, this.width, this.height, this.alignment})
      : _left = direction == BubbleDirection.left ? _ArrowWidth : 0.0,
        _right = direction == BubbleDirection.right ? _ArrowWidth : 0.0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper:
      _BubbleClipper(direction, this.borderRadius ?? Radius.circular(5.0)),
      child: Container(
        alignment: this.alignment,
        width: this.width,
        height: this.height,
        constraints: (this.constraints??BoxConstraints()).copyWith(minHeight: _MinHeight,minWidth: _MinWidth),
        margin: this.margin,
        color: this.color,
        padding: EdgeInsets.fromLTRB(this._left, 0.0, this._right, 0.0).add(this.padding??EdgeInsets.fromLTRB(7.0, 5.0, 7.0, 5.0)),
        child: this.child,
      ),
    );
  }
}

///方向
enum BubbleDirection { left, right }

class _BubbleClipper extends CustomClipper<Path> {
  final BubbleDirection direction;
  final Radius radius;
  _BubbleClipper(this.direction, this.radius);

  @override
  Path getClip(Size size) {
    final path = Path();
    final path2 = Path();
    if (this.direction == BubbleDirection.left) {
      //绘制左边三角形
      path.moveTo(0, _ArrowTop);
      path.lineTo(_ArrowWidth, _ArrowTop);
      path.lineTo(_ArrowWidth, _ArrowTop + _ArrowHeight);
      path.close();
      //绘制矩形
      path2.addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(_ArrowWidth, 0, (size.width - _ArrowWidth), size.height), this.radius));
      //合并
      path.addPath(path2, Offset(0, 0));
    } else {
      //绘制右边三角形
      path.moveTo(size.width, _ArrowTop);
      path.lineTo(size.width - _ArrowWidth, _ArrowTop);
      path.lineTo(size.width - _ArrowWidth, _ArrowTop + _ArrowHeight);
      path.close();
      //绘制矩形
      path2.addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, (size.width - _ArrowWidth), size.height), this.radius));
      //合并
      path.addPath(path2, Offset(0, 0));
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
