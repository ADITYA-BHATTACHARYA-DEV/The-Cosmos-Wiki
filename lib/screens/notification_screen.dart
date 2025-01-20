
import 'package:flutter/material.dart';
import 'package:planet/theme/app_theme.dart';

class NotificationScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title': 'Breaking News: Water on Mars!',
      'description': 'NASA confirms the presence of liquid water on Mars.',
      'time': '2 hours ago',
    },
    {
      'title': 'Upcoming Meteor Shower',
      'description': 'Don\'t miss the Perseids meteor shower this weekend!',
      'time': '5 hours ago',
    },
    {
      'title': 'New Exoplanet Discovery',
      'description': 'Astronomers find Earth-like planet in habitable zone.',
      'time': '1 day ago',
    },
    {
      'title': 'Solar Flare Alert',
      'description': 'Massive solar flare may cause auroras at lower latitudes.',
      'time': '2 days ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return NewsFlashNotification(
          title: notifications[index]['title']!,
          description: notifications[index]['description']!,
          time: notifications[index]['time']!,
        );
      },
    );
  }
}

class NewsFlashNotification extends StatefulWidget {
  final String title;
  final String description;
  final String time;

  const NewsFlashNotification({
    Key? key,
    required this.title,
    required this.description,
    required this.time,
  }) : super(key: key);

  @override
  _NewsFlashNotificationState createState() => _NewsFlashNotificationState();
}

class _NewsFlashNotificationState extends State<NewsFlashNotification> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
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
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: Offset(_slideAnimation.value, 0),
            child: child,
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: AppTheme.spaceDarkBlue.withOpacity(0.8),
        child: ListTile(
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              Text(
                widget.description,
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(height: 4),
              Text(
                widget.time,
                style: TextStyle(color: AppTheme.spacePurple, fontSize: 12),
              ),
            ],
          ),
          trailing: Icon(Icons.notifications_active, color: AppTheme.spacePurple),
        ),
      ),
    );
  }
}

