
import 'package:flutter/material.dart';
import 'package:planet/theme/app_theme.dart';

class NewsCarousel extends StatefulWidget {
  @override
  _NewsCarouselState createState() => _NewsCarouselState();
}

class _NewsCarouselState extends State<NewsCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;

  final List<Map<String, String>> newsItems = [
    {
      'title': 'New Exoplanet Discovered',
      'description': 'Astronomers find Earth-like planet in habitable zone',
      'image': 'assets/images/sp3.jpg',
    },
    {
      'title': 'Supernova Explosion Observed',
      'description': 'Hubble telescope captures rare stellar event',
      'image': 'assets/images/space.jpeg',
    },
    {
      'title': 'Mars Rover Makes Groundbreaking Discovery',
      'description': 'Evidence of ancient microbial life found on Mars',
      'image': 'assets/images/sp1.jpeg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         SizedBox(height: 60),
        Container(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: newsItems.length,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                  }
                  return Center(
                    child: SizedBox(
                      height: Curves.easeInOut.transform(value) * 200,
                      width: Curves.easeInOut.transform(value) * 350,
                      child: child,
                    ),
                  );
                },
                child: NewsCard(
                  title: newsItems[index]['title']!,
                  description: newsItems[index]['description']!,
                  imageUrl: newsItems[index]['image']!,
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            newsItems.length,
            (index) => AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: _currentPage == index ? 16 : 8,
              height: 8,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _currentPage == index ? AppTheme.spacePurple : Colors.grey,
              ),
            ),
          ),
        ),
        SizedBox(height: 18),
      ],
    );
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const NewsCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  description,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

