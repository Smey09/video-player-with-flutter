import 'package:flutter/material.dart';
import 'package:movie_from_github/models/movieModel.dart';
import 'package:movie_from_github/screens/display/videoPlay.dart';

class ListType extends StatelessWidget {
  final Result movie;
  final List<Result> movies;

  const ListType({super.key, required this.movie, required this.movies});

  @override
  Widget build(BuildContext context) {
    movies.shuffle(); // get random video to show
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => YoutubePlayerScreen(
              movie: movie,
              movies: movies,
            ),
          ),
        );
      },
      child: Container(
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
              height: 135,
              width: MediaQuery.of(context).size.width * 0.25,
              child: movie.posterPath.isNotEmpty
                  ? Image.network(
                      movie.posterPath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 150,
                        width: 100,
                        color: Colors.black.withOpacity(0.1),
                        child: const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
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
              width: MediaQuery.of(context).size.width * 0.60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      movie.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const Divider(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
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
                            size: 15,
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
                  const Divider(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 25,
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
                              padding: EdgeInsets.only(left: 5, right: 5),
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
                          height: 25,
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
                              padding: EdgeInsets.only(left: 5, right: 5),
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
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
