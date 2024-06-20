import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:movie_from_github/screens/display/movie-screen.dart';
import 'package:movie_from_github/screens/favorites/favorite.dart';
import 'package:movie_from_github/screens/main/appBar.dart';
import 'package:movie_from_github/screens/main/tabBar-screen.dart';
import 'package:movie_from_github/screens/music/music.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar_Screen(context),
      body: _buildBody(),
      bottomNavigationBar: _buildBottom(),
    );
  }

  Widget _buildBody() {
    return IndexedStack(
      index: _currentIndex,
      children: [
        const TabBarScreen(),
        const MovieListScreen(),
        const Favorite(),
        MusicScreen(),
      ],
    );
  }

  Widget _buildBottom() {
    return CurvedNavigationBar(
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      animationDuration: const Duration(milliseconds: 300),
      items: const [
        Icon(Icons.home),
        Icon(Icons.movie),
        Icon(Icons.favorite),
        Icon(Icons.music_note),
      ],
    );
  }
}
