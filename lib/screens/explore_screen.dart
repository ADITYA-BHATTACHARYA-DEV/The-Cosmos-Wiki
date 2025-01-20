
import 'package:flutter/material.dart';
import 'package:planet/widgets/news_carousel.dart';

class ExploreScreen extends StatelessWidget {
  final List<Map<String, String>> exploreItems = [
    {
      'title': 'Nebula Discoveries',
      'description': 'New stellar nurseries found in the Orion constellation',
      'image': 'assets/images/nebula.jpg',
    },
    {
      'title': 'Mars Rover Update',
      'description': 'Perseverance finds traces of ancient microbial life',
      'image': 'assets/images/milkyway.jpg',
    },
    {
      'title': 'Exoplanet Weather',
      'description': 'Extreme storms detected on distant gas giant',
      'image': 'assets/images/exoplanet.jpg',
    },
    {
      'title': 'Black Hole Merger',
      'description': 'Gravitational waves from colliding black holes detected',
      'image': 'assets/images/black_hole.jpg',
    },
     {
      'title': 'Supernova',
      'description': 'Gravitational waves from SuperNova',
      'image': 'assets/images/space.jpeg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      
      slivers: [
        
        SliverToBoxAdapter(
          
          
          child: Padding(
            
            padding: const EdgeInsets.all(16.0),
            
            child: Text(
              
              '',
              style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.white),
            ),
            
          ),
        ),
        SliverToBoxAdapter(
          child: NewsCarousel(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final item = exploreItems[index];
              return ExploreCard(
                title: item['title']!,
                description: item['description']!,
                imageUrl: item['image']!,
              );
            },
            childCount: exploreItems.length,
          ),
        ),
      ],
    );
  }
}

class ExploreCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const ExploreCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imageUrl),
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
              title,
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

