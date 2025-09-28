import 'dart:math';
import 'package:flutter/material.dart';

class DynamicCircleProgress extends StatelessWidget {
  final double progress; // نسبة التقدم التي يتم تمريرها من الخارج
  final Widget child; // المحتوى الديناميكي داخل الدائرة
  final Widget? icon; // الأيقونة القابلة للتغيير في أعلى الدائرة

  const DynamicCircleProgress({
    super.key,
    required this.progress,
    required this.child,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.27,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // الدائرة مع التقدم بناءً على نسبة `progress`
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: progress),
              duration: Duration(seconds: 1),
              builder: (context, double animatedProgress, child) {
                return CustomPaint(
                  size: Size(MediaQuery.of(context).size.width * 0.5,
                      MediaQuery.of(context).size.height * 0.5),
                  painter: FullCircleProgressPainter(animatedProgress),
                );
              },
            ),
            if (icon != null)
              Positioned(
                top: 0,
                child: icon!,
              ),
            child,
          ],
        ),
      ),
    );
  }
}

class FullCircleProgressPainter extends CustomPainter {
  final double progress;

  FullCircleProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    Paint progressPaint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      backgroundPaint,
    );

    double startAngle = -pi / 2;
    double sweepAngle = 2 * pi * progress;

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
