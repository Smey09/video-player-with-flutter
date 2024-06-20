import 'package:flutter/material.dart';
import 'package:movie_from_github/models/movieModel.dart';
import 'package:movie_from_github/screens/home/home-list.dart';
import 'package:movie_from_github/screens/home/home-search.dart';
import 'package:movie_from_github/service/movie-service.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  late Future<MovieModel> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _moviesFuture = fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FutureBuilder<MovieModel>(
                future: _moviesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData ||
                      snapshot.data!.results.isEmpty) {
                    return const Center(child: Text('No data found'));
                  } else {
                    return SearchScreen(movieModel: snapshot.data!);
                  }
                },
              ),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        elevation: 5.0,
        child: const Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder<MovieModel>(
        future: _moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.results.isEmpty) {
            return const Center(child: Text('No data found'));
          } else {
            final movies = snapshot.data!.results;
            Set<String> uniqueCategories =
                movies.map((movie) => movie.typeMovie).toSet();
            uniqueCategories.removeWhere((element) => element.isEmpty);

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Container(
                  //   margin: const EdgeInsets.only(
                  //       top: 5.0, left: 10.0, right: 10.0),
                  //   child: SingleChildScrollView(
                  //     scrollDirection: Axis.horizontal,
                  //     child: Row(
                  //       children: [
                  //         for (final category in uniqueCategories)
                  //           _buildCategoryButton(context, category),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  HomeListView(movies: movies),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, String category) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: TextButton(
        onPressed: () {
          print('Category: $category');
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: Colors.blue.withOpacity(0.4),
        ),
        child: Text(
          category,
          style: const TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
