import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_from_github/models/movieModel.dart';

Future<MovieModel> fetchMovies() async {
  final response = await http.get(
    Uri.parse(
        'https://raw.githubusercontent.com/Smey09/Fake-data-for-testing/main/tes-with-videoID.json'),
  );
  if (response.statusCode == 200) {
    return MovieModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load movie data');
  }
}
