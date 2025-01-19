import 'dart:math' as math;

import 'package:flutter/material.dart';

class RotatingPlanet extends StatefulWidget {
  const RotatingPlanet({Key? key}) : super(key: key);

  @override
  _RotatingPlanetState createState() => _RotatingPlanetState();
}

class _RotatingPlanetState extends State<RotatingPlanet> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
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
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: child,
        );
      },
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage('assets/images/globe.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

