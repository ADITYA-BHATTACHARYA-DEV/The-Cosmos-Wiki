import 'dart:math' as math;

import 'package:flutter/material.dart';

class RevolvingPlanet extends StatefulWidget {
  @override
  _RevolvingPlanetState createState() => _RevolvingPlanetState();
}

class _RevolvingPlanetState extends State<RevolvingPlanet> with SingleTickerProviderStateMixin {
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
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(2 * math.pi * _controller.value),
          child: child,
        );
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
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

