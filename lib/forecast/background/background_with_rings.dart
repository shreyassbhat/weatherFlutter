import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class BackgroundWithRings extends StatelessWidget {

  final ImageProvider rawBackground;
  final ImageProvider frostedBackground;
  final double seeThruCircleRadius;
  final Offset seeThruCircleOffset;

  BackgroundWithRings({
    @required this.rawBackground,
    @required this.frostedBackground,
    @required this.seeThruCircleRadius,
    @required this.seeThruCircleOffset,
  });

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // Blurry background.
        new Image(
          image: frostedBackground,
          fit: BoxFit.cover,
        ),

        // Crisp background that is masked to a small circle on the left.
        new ClipOval(
          clipper: new CircleClipper(
            radius: seeThruCircleRadius,
            offset: seeThruCircleOffset,
          ),
          child: new Image(
            image: rawBackground,
            fit: BoxFit.cover,
          ),
        ),

        // Translucent overlay painted on top of background with rings.
        new CustomPaint(
          painter: new WhiteCircleCutoutPainter(
            centerOffset: seeThruCircleOffset,
            circles: [
              new Circle(radius: seeThruCircleRadius, alpha: 0x10),
              new Circle(radius: seeThruCircleRadius + 15.0, alpha: 0x28),
              new Circle(radius: seeThruCircleRadius + 30.0, alpha: 0x38),
              new Circle(radius: seeThruCircleRadius + 75.0, alpha: 0x50),
            ],
          ),
          child: new Container(),
        ),
      ],
    );
  }
}

class CircleClipper extends CustomClipper<Rect> {

  final double radius;
  final Offset offset;

  CircleClipper({
    this.radius,
    this.offset = const Offset(0.0, 0.0),
  });

  @override
  Rect getClip(Size size) {
    return new Rect.fromCircle(
      center: new Offset(0.0, size.height / 2) + offset,
      radius: radius,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }

}

class WhiteCircleCutoutPainter extends CustomPainter {

  final Color overlayColor = const Color(0xFFAA88AA);

  final List<Circle> circles;
  final Offset centerOffset;
  final Paint whitePaint;
  final Paint borderPaint;

  WhiteCircleCutoutPainter({
    this.circles = const [],
    this.centerOffset = const Offset(0.0, 0.0),
  }) : whitePaint = new Paint(),
        borderPaint = new Paint() {
    borderPaint
      ..color = const Color(0x10FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 1; i < circles.length; ++i) {
      _maskCircle(canvas, size, circles[i - 1].radius);

      whitePaint.color = overlayColor.withAlpha(circles[i-1].alpha);

      // Fill circle
      canvas.drawCircle(
        new Offset(0.0, size.height / 2) + centerOffset,
        circles[i].radius,
        whitePaint,
      );

      // Draw circle bevel
      canvas.drawCircle(
        new Offset(0.0, size.height / 2) + centerOffset,
        circles[i - 1].radius,
        borderPaint,
      );
    }

    // Mask the area of the final circle
    _maskCircle(canvas, size, circles.last.radius);

    // Draw an overlay that fills the rest of the screen.
    whitePaint.color = overlayColor.withAlpha(circles.last.alpha);
    canvas.drawRect(
        new Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        whitePaint
    );

    // Draw the bevel for the final circle.
    canvas.drawCircle(
        new Offset(0.0, size.height / 2) + centerOffset,
        circles.last.radius,
        borderPaint
    );
  }

  _maskCircle(Canvas canvas, Size size, double radius) {
    Path clippedCircle = new Path();
    clippedCircle.fillType = PathFillType.evenOdd;
    clippedCircle.addRect(new Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    clippedCircle.addOval(
      new Rect.fromCircle(
        center: new Offset(0.0, size.height / 2) + centerOffset,
        radius: radius,
      ),
    );
    canvas.clipPath(clippedCircle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}

class Circle {
  final double radius;
  final int alpha;

  Circle({
    this.radius,
    this.alpha = 0xFF,
  });
}