import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:movie_from_github/models/TabBarModel.dart';
import 'package:movie_from_github/screens/home/main-home.dart';
import 'package:movie_from_github/screens/movie-categories/movie-list.dart';

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({super.key});

  static const List<TabInfo> tabInfoList = [
    TabInfo(text: "Home", typeMovie: ""),
    TabInfo(text: "Drama", typeMovie: "Drama"),
    TabInfo(text: "Remix", typeMovie: "Remix"),
    TabInfo(text: "Hip Hop", typeMovie: "Hip Hop"),
    TabInfo(text: "Speed Up", typeMovie: "Speed up"),
    TabInfo(text: "Cover Song", typeMovie: "Cover"),
    TabInfo(text: "Pop", typeMovie: "Pop"),
    TabInfo(text: "Rapper", typeMovie: "Rapper"),
    TabInfo(text: "Official Music", typeMovie: "Official Music Video"),
    TabInfo(text: "Animation", typeMovie: "Animation"),
    TabInfo(text: "Adventure", typeMovie: "Adventure"),
    TabInfo(
        text: "Science Fiction, Action", typeMovie: "Science Fiction, Action"),
    TabInfo(text: "Drama, History", typeMovie: "Drama, History"),
    TabInfo(
        text: "Science Fiction, Thriller",
        typeMovie: "Science Fiction, Thriller"),
    TabInfo(text: "Drama, Western", typeMovie: "Drama, Western"),
    TabInfo(
        text: "Science Fiction, Adventure",
        typeMovie: "Science Fiction, Adventure"),
    TabInfo(text: "Comedy, Drama", typeMovie: "Comedy, Drama"),
    TabInfo(text: "Drama, Music", typeMovie: "Drama, Music"),
    TabInfo(text: "Mystery, Thriller", typeMovie: "Mystery, Thriller"),
    TabInfo(text: "Crime, Thriller", typeMovie: "Crime, Thriller"),
    TabInfo(
        text: "Science Fiction, Romance",
        typeMovie: "Science Fiction, Romance"),
    TabInfo(text: "Drama, Romance", typeMovie: "Drama, Romance"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: tabInfoList.length,
          child: Column(
            children: <Widget>[
              ButtonsTabBar(
                height: 35,
                backgroundColor: Colors.blue,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                tabs: tabInfoList
                    .map(
                      (info) => Tab(text: info.text.toLowerCase()),
                    )
                    .toList(),
              ),
              Expanded(
                child: TabBarView(
                  children: tabInfoList.map((info) {
                    if (info.text == "Home") {
                      return const MainHome();
                    } else {
                      return info.typeMovie.isEmpty
                          ? const MainHome()
                          : MovieList(typeMovie: info.typeMovie);
                    }
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
