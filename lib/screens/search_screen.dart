
import 'package:flutter/material.dart';
import 'package:planet/theme/app_theme.dart';
import 'package:planet/widgets/revolving_planet.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RevolvingPlanet(),
        Positioned.fill(
          child: Column(
            children: [
               SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.all(16.0),
                
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search the cosmos...',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    _buildSearchResult('Solar System', 'Our cosmic neighborhood'),
                    _buildSearchResult('Black Holes', 'The most mysterious objects in the universe'),
                    _buildSearchResult('Galaxies', 'Island universes in the cosmic ocean'),
                    _buildSearchResult('Exoplanets', 'Worlds beyond our solar system'),
                    _buildSearchResult('Dark Matter', 'The invisible cosmic glue'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResult(String title, String description) {
    return Card(
      color: AppTheme.spaceDarkBlue.withOpacity(0.6),
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(title, style: TextStyle(color: Colors.white)),
        subtitle: Text(description, style: TextStyle(color: Colors.white70)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
        onTap: () {
          // Navigate to search result
        },
      ),
    );
  }
}

