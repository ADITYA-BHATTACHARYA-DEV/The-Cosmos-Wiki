import 'dart:math';

import 'package:flutter/material.dart';

class MovingStarsBackground extends StatefulWidget {
  final int starCount;

  const MovingStarsBackground({Key? key, this.starCount = 100}) : super(key: key);

  @override
  _MovingStarsBackgroundState createState() => _MovingStarsBackgroundState();
}

class _MovingStarsBackgroundState extends State<MovingStarsBackground> with SingleTickerProviderStateMixin {
  late List<Star> stars;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    stars = List.generate(widget.starCount, (_) => Star());
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: StarPainter(stars, _controller.value),
          child: Container(),
        );
      },
    );
  }
}

class Star {
  double x;
  double y;
  double speed;
  double size;

  Star()
      : x = Random().nextDouble(),
        y = Random().nextDouble(),
        speed = Random().nextDouble() * 1.02 + 1.01,
        size = Random().nextDouble() * 2 + 1;
}

class StarPainter extends CustomPainter {
  final List<Star> stars;
  final double animation;

  StarPainter(this.stars, this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    for (final star in stars) {
      final screenX = star.x * size.width;
      final screenY = (star.y + animation * star.speed) % 1.0 * size.height;

      canvas.drawCircle(Offset(screenX, screenY), star.size, paint);
    }
  }

  @override
  bool shouldRepaint(StarPainter oldDelegate) => true;
}

