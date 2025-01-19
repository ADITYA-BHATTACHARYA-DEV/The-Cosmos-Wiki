import 'package:flutter/material.dart';

class AnimatedSideDrawer extends StatelessWidget {
  const AnimatedSideDrawer({
    Key? key,
    required this.onClose,
    required this.drawerAnimationValue,
  }) : super(key: key);

  final void Function() onClose;
  final double drawerAnimationValue;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: drawerAnimationValue,
      duration: Duration(milliseconds: 300),
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepPurple[900]!,
                Colors.black,
              ],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/cosmos_header.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Text(
                  'Cosmos Wiki',
                  style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.white),
                ),
              ),
              _buildAnimatedListTile(context, 'Latest Discoveries', Icons.lightbulb),
              _buildAnimatedListTile(context, 'Space Missions', Icons.rocket_launch),
              _buildAnimatedListTile(context, 'Astronomers', Icons.person),
              _buildAnimatedListTile(context, 'Cosmic Calendar', Icons.calendar_today),
              _buildAnimatedListTile(context, 'Settings', Icons.settings),
              _buildAnimatedListTile(context, 'About', Icons.info),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedListTile(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: () {
        // Handle navigation
        Navigator.pop(context);
        onClose();
      },
    );
  }
}
