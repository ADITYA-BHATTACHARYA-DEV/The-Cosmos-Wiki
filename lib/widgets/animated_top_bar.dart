import 'package:flutter/material.dart';

class AnimatedTopBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;

  const AnimatedTopBar({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.8),
              Colors.transparent,
            ],
          ),
        ),
      ),
      bottom: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
        ),
        tabs: [
          Tab(text: 'Home'),
          Tab(text: 'Explore'),
          Tab(text: 'Gallery'),
          Tab(text: 'Profile'),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 48);
}

