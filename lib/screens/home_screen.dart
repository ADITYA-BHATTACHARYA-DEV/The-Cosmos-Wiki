import 'package:flutter/material.dart';
import 'package:planet/models/cosmos_article.dart';
import 'package:planet/screens/article_screen.dart';
import 'package:planet/screens/explore_screen.dart';
import 'package:planet/screens/notification_screen.dart';
import 'package:planet/screens/search_screen.dart';
import 'package:planet/theme/app_theme.dart';
import 'package:planet/widgets/animated_bottom_nav.dart';
import 'package:planet/widgets/animated_side_drawer.dart';
import 'package:planet/widgets/chatbot_button.dart';
import 'package:planet/widgets/moving_stars_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _drawerAnimationController;
  late Animation<double> _drawerAnimation;
  int _currentIndex = 0;
  bool _isDrawerVisible = false;

  final List<CosmosArticle> featuredArticles = [
    CosmosArticle(
      title: 'Exploring Black Holes',
      summary: 'Journey into the heart of cosmic mysteries',
      imageUrl: 'assets/images/black_hole.jpg',
    ),
    CosmosArticle(
      title: 'The Milky Way Galaxy',
      summary: 'Our cosmic home in the vast universe',
      imageUrl: 'assets/images/milkyway.jpg',
    ),
    CosmosArticle(
      title: 'Exoplanets: New Worlds',
      summary: 'Discovering planets beyond our solar system',
      imageUrl: 'assets/images/exoplanet.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _drawerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _drawerAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _drawerAnimationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _drawerAnimationController.dispose();
    super.dispose();
  }

  void _toggleDrawer() {
    if (_drawerAnimationController.isCompleted) {
      _drawerAnimationController.reverse();
    } else {
      _drawerAnimationController.forward();
    }

    setState(() {
      _isDrawerVisible = !_isDrawerVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: _toggleDrawer,
        ),
        title: Text('Cosmos Wiki', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Stack(
        children: [
          MovingStarsBackground(),
          AnimatedBuilder(
            animation: _drawerAnimation,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(_drawerAnimation.value * -0.5),
                alignment: Alignment.centerRight,
                child: child,
              );
            },
            child: _buildMainContent(),
          ),
          AnimatedBuilder(
            animation: _drawerAnimation,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(_drawerAnimation.value * MediaQuery.of(context).size.width * 0.7)
                  ..rotateY(_drawerAnimation.value * -0.5),
                alignment: Alignment.centerLeft,
                child: child,
              );
            },
            child: AnimatedSideDrawer(onClose: _toggleDrawer, drawerAnimationValue: _isDrawerVisible ? 1.0 : 0.0),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: ChatbotButton(),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildMainContent() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return ExploreScreen();
      case 2:
        return SearchScreen();
      case 3:
        return NotificationScreen();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return ListView(
      padding: EdgeInsets.all(16),
      
      children: [
        SizedBox(height: 20),
        SizedBox(height: AppBar().preferredSize.height),
        Text(
          'Discover the Cosmos',
          style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        _buildFeaturedArticle(featuredArticles[0]),
        SizedBox(height: 20),
        Text(
          'Explore More',
          style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ...featuredArticles.sublist(1).map((article) => _buildArticleCard(article)).toList(),
      ],
    );
  }

  Widget _buildFeaturedArticle(CosmosArticle article) {
    return GestureDetector(
      onTap: () => _navigateToArticle(article),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(article.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.title,
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                article.summary,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticleCard(CosmosArticle article) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      color: AppTheme.spaceDarkBlue.withOpacity(0.6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            article.imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(article.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(article.summary, style: TextStyle(color: Colors.white70)),
        onTap: () => _navigateToArticle(article),
      ),
    );
  }

  void _navigateToArticle(CosmosArticle article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleScreen(article: article),
      ),
    );
  }
}