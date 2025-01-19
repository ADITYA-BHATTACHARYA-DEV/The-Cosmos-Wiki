import 'package:flutter/material.dart';

class ShootingStar extends StatefulWidget {
  const ShootingStar({Key? key}) : super(key: key);

  @override
  _ShootingStarState createState() => _ShootingStarState();
}

class _ShootingStarState extends State<ShootingStar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(-1.5, -1.5),
      end: const Offset(1.5, 1.5),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Container(
        width: 4,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
            ),
          ],
        ),
      ),
    );
  }
}

