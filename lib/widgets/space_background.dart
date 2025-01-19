import 'dart:math'; // Importing the Random class

import 'package:flutter/material.dart';

class SpaceBackground extends StatelessWidget {
  SpaceBackground({Key? key}) : super(key: key);

  // Reuse a single Random instance to improve performance and randomness
  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0B0D17),
            Color(0xFF1B1E2F),
            Color(0xFF2C2F4A),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Add twinkling stars effect here
          for (int i = 0; i < 50; i++)
            Positioned(
              left: _randomPosition(size.width),
              top: _randomPosition(size.height),
              child: _buildStar(),
            ),
        ],
      ),
    );
  }

  Widget _buildStar() {
    final size = _randomStarSize();
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }

  double _randomPosition(double max) {
    return random.nextDouble() * max; // Generates a value between 0 and max
  }

  double _randomStarSize() {
    return 1 + random.nextDouble() * 2; // Generates a value between 1 and 3
  }
}
