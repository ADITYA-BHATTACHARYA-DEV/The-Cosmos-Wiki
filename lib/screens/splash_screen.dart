import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:planet/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _cometAnimation;
  late AnimationController _starController;
  late List<Offset> starPositions;

  @override
  void initState() {
    super.initState();

    // Initialize an empty list for star positions
    starPositions = [];

    // Animation for comet fall
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 3));
    _cometAnimation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 1)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start comet animation
    _controller.forward();

    // Star animation controller for continuous twinkling
    _starController = AnimationController(vsync: this, duration: Duration(seconds: 1))..repeat(reverse: true);

    // Generate random star positions after context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        starPositions = List.generate(100, (index) {
          return Offset(
            Random().nextDouble() * MediaQuery.of(context).size.width,
            Random().nextDouble() * MediaQuery.of(context).size.height,
          );
        });
      });
    });

    // Navigate to HomeScreen after 4 seconds
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _starController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Black Background with glowing gradient effect
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.5,
                colors: [
                  Colors.blueAccent.withOpacity(0.8),
                  Colors.purple.withOpacity(0.6),
                  Colors.black,
                ],
              ),
            ),
            child: _buildStars(),
          ),

          // Spinning Globe
          Center(
            child: Transform.rotate(
              angle: _controller.value * 6.3, // Rotating effect
              child: Icon(
                Icons.public,
                size: 100,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ),

          // Comet Animation
          AnimatedBuilder(
            animation: _cometAnimation,
            builder: (context, child) {
              return Positioned(
                top: MediaQuery.of(context).size.height * 0.1 + _cometAnimation.value.dy * 200,
                left: MediaQuery.of(context).size.width * 0.5,
                child: Icon(
                  Icons.star,
                  size: 50,
                  color: Colors.white.withOpacity(0.7),
                ),
              );
            },
          ),

          // Title Text
          Positioned(
            bottom: 50,
            left: MediaQuery.of(context).size.width * 0.25,
            child: Text(
              'Cosmos Wiki',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.7),
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to build and animate the stars
  Widget _buildStars() {
    // Check if starPositions is empty
    if (starPositions.isEmpty) {
      return Container();
    }

    return AnimatedBuilder(
      animation: _starController,
      builder: (context, child) {
        return Stack(
          children: List.generate(starPositions.length, (index) {
            double opacity = 0.3 + Random().nextDouble() * 0.7;
            return Positioned(
              top: starPositions[index].dy,
              left: starPositions[index].dx,
              child: Opacity(
                opacity: opacity,
                child: Icon(
                  Icons.star,
                  size: 2 + Random().nextInt(2).toDouble(),
                  color: Colors.white.withOpacity(opacity),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
