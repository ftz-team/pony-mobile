import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnicornOutlineButton extends StatelessWidget {
  final _GradientPainter _painter;
  final Widget _child;
  final VoidCallback _callback;
  final double _radius;

  UnicornOutlineButton({
    required double strokeWidth,
    required double radius,
    required Gradient gradient,
    required Widget child,
    required VoidCallback onPressed,
  })  : this._painter = _GradientPainter(
            strokeWidth: strokeWidth, radius: radius, gradient: gradient),
        this._child = child,
        this._callback = onPressed,
        this._radius = radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _callback,
        child: InkWell(
          borderRadius: BorderRadius.circular(_radius),
          onTap: _callback,
          child: Container(
            constraints: BoxConstraints(minWidth: 88, minHeight: 48),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter(
      {required double strokeWidth,
      required double radius,
      required Gradient gradient})
      : this.strokeWidth = strokeWidth,
        this.radius = radius,
        this.gradient = gradient;

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}

Widget DefaultButton({
  required Widget child,
  required VoidCallback onPressed,
    double paddingVert = 15
}) {
  return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.translucent,
      child: new Material(
        color: Colors.black,
        child: InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: paddingVert),
            decoration: BoxDecoration(
                gradient: UIGradients.Main,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: child,
          ),
        ),
      ));
}

Widget SecondaryButton(
    {required Widget child, required VoidCallback onPressed}) {
  return InkWell(
    onTap: onPressed,
      child: Container(
          child: child,
          decoration: BoxDecoration(
              color: UIColors.secondary,
              borderRadius: BorderRadius.all(Radius.circular(14))),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15)));
}

Widget MiniGradientButton(
    {required Widget child, required VoidCallback onPressed}) {
  return InkWell(
      onTap: onPressed,
      child: Container(
          child: child,
          decoration: BoxDecoration(
              gradient: UIGradients.Main,
              borderRadius: BorderRadius.all(Radius.circular(14))),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15)));
}