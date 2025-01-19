import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AnimatedBottomNav({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.8),
          ],
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.white60,
        items: [
          _buildNavItem(icon: Icons.home, label: 'Home', animationType: AnimationType.scale),
          _buildNavItem(icon: Icons.explore, label: 'Explore', animationType: AnimationType.bounce),
          _buildNavItem(icon: Icons.search, label: 'Search', animationType: AnimationType.shake),
          _buildNavItem(icon: Icons.notifications, label: 'Notifications', animationType: AnimationType.rotation),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required IconData icon,
    required String label,
    AnimationType? animationType,
  }) {
    return BottomNavigationBarItem(
      icon: animationType != null
          ? AnimatedNavIcon(icon: icon, animationType: animationType)
          : Icon(icon),
      label: label,
    );
  }
}

enum AnimationType { rotation, scale, bounce, shake }

class AnimatedNavIcon extends StatefulWidget {
  final IconData icon;
  final AnimationType animationType;

  const AnimatedNavIcon({
    Key? key,
    required this.icon,
    required this.animationType,
  }) : super(key: key);

  @override
  _AnimatedNavIconState createState() => _AnimatedNavIconState();
}

class _AnimatedNavIconState extends State<AnimatedNavIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isTapped = false; // Track whether the icon is tapped

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600), // Smooth transition duration
      vsync: this,
    );

    switch (widget.animationType) {
      case AnimationType.rotation:
        _animation = Tween<double>(begin: 0, end: 1.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        break;
      case AnimationType.scale:
        _animation = Tween<double>(begin: 1.0, end: 1.3).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        break;
      case AnimationType.bounce:
        _animation = Tween<double>(begin: 0, end: 15).animate(
          CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
        );
        break;
      case AnimationType.shake:
        _animation = Tween<double>(begin: -8, end: 8).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        break;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    if (!_isTapped) {
      _controller.forward();
      setState(() {
        _isTapped = true;
      });
    } else {
      _controller.reverse();
      setState(() {
        _isTapped = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnimation, // Start animation on tap
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          switch (widget.animationType) {
            case AnimationType.rotation:
              return Transform.rotate(
                angle: _animation.value * 2 * math.pi,
                child: child,
              );
            case AnimationType.scale:
              return Transform.scale(
                scale: _animation.value,
                child: child,
              );
            case AnimationType.bounce:
              return Transform.translate(
                offset: Offset(0, -_animation.value),
                child: child,
              );
            case AnimationType.shake:
              return Transform.translate(
                offset: Offset(_animation.value, 0),
                child: child,
              );
            default:
              return Icon(widget.icon);
          }
        },
        child: Icon(widget.icon),
      ),
    );
  }
}
