import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:planet/theme/app_theme.dart';

class ChatbotButton extends StatefulWidget {
  const ChatbotButton({Key? key}) : super(key: key);

  @override
  _ChatbotButtonState createState() => _ChatbotButtonState();
}

class _ChatbotButtonState extends State<ChatbotButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _rotateAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    _controller.forward().then((_) => _controller.reverse());
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return GoogleAssistantPopup();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle: _rotateAnimation.value,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.spacePurple,
                      AppTheme.spaceBlue,
                    ],
                  ),
                ),
                child: Lottie.asset(
                  'assets/images/bot1.json',
                  // errorBuilder: (context, error, stackTrace) {
                  //   return Icon(Icons.error, color: Colors.red);
                  // },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class GoogleAssistantPopup extends StatefulWidget {
  @override
  _GoogleAssistantPopupState createState() => _GoogleAssistantPopupState();
}

class _GoogleAssistantPopupState extends State<GoogleAssistantPopup> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (1 - _animation.value) * MediaQuery.of(context).size.height / 3),
          child: Opacity(
            opacity: _animation.value,
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                color: AppTheme.spaceBlack,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MicAnimation(),
                  SizedBox(height: 20),
                  Text(
                    'Listening...',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  GoogleLoadingBar(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MicAnimation extends StatefulWidget {
  @override
  _MicAnimationState createState() => _MicAnimationState();
}

class _MicAnimationState extends State<MicAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1, end: 1.5).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Icon(
            Icons.mic,
            color: AppTheme.spacePurple,
            size: 50,
          ),
        );
      },
    );
  }
}

class GoogleLoadingBar extends StatefulWidget {
  @override
  _GoogleLoadingBarState createState() => _GoogleLoadingBarState();
}

class _GoogleLoadingBarState extends State<GoogleLoadingBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 4,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: GoogleLoadingBarPainter(_animation.value),
          );
        },
      ),
    );
  }
}

class GoogleLoadingBarPainter extends CustomPainter {
  final double animationValue;

  GoogleLoadingBarPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.spacePurple
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    final startX = size.width * animationValue - size.width / 4;
    final endX = startX + size.width / 2;

    canvas.drawLine(
      Offset(startX < 0 ? 0 : startX, size.height / 2),
      Offset(endX > size.width ? size.width : endX, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(GoogleLoadingBarPainter oldDelegate) => true;
}
