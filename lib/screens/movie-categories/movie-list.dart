// Movie list widget that shows movies based on typeMovie
import 'package:flutter/material.dart';
import 'package:movie_from_github/models/movieModel.dart';
import 'package:movie_from_github/screens/display/videoPlay.dart';
import 'package:movie_from_github/service/movie-service.dart';

class MovieList extends StatelessWidget {
  final String typeMovie;

  const MovieList({required this.typeMovie, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<MovieModel>(
        future: fetchMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          } else {
            final movies = snapshot.data!.results
                .where((movie) =>
                    typeMovie.isEmpty || movie.typeMovie == typeMovie)
                .toList();
            if (movies.isEmpty) {
              return Center(child: Text('No movies found for $typeMovie'));
            }
            // Shuffle the movies list randomly
            movies.shuffle();
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            YoutubePlayerScreen(movie: movie, movies: movies),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.blue.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: movie.posterPath.isNotEmpty
                              ? Image.network(
                                  movie.posterPath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    height: 150,
                                    width: 100,
                                    color: Colors.black.withOpacity(0.1),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Color.fromARGB(255, 243, 0, 166),
                                        ),
                                        backgroundColor: Colors.blue,
                                        strokeWidth: 2.0,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Text(
                                  movie.title,
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontFamily: 'Impact',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    // movie.releaseDate,
                                    movie.releaseDate,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${movie.voteAverage}",
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Poppins',
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: Colors.red,
                                        size: 14,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        movie.formattedVoteCount,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Poppins',
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      const Text(
                                        "Ratings",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue.withOpacity(0.1),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.blue.withOpacity(0.1),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
                                        child: Row(
                                          children: [
                                            Text("See More"),
                                            SizedBox(width: 5),
                                            Icon(
                                              Icons.more_horiz,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue.withOpacity(0.1),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.blue.withOpacity(0.1),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
                                        child: Row(
                                          children: [
                                            Text("Watch Now"),
                                            SizedBox(width: 5),
                                            Icon(
                                              Icons.remove_red_eye,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
