import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/musicModel.dart';

Future<MusicModel> fetchMusicData() async {
  final response = await http.get(Uri.parse('https://raw.githubusercontent.com/Smey09/Fake-data-for-testing/main/music-data.json'));

  if (response.statusCode == 200) {
    try {
      final jsonData = jsonDecode(response.body);
      return MusicModel.fromJson(jsonData);
    } catch (e) {
      print('Error parsing JSON: $e');
      throw Exception('Failed to parse music data');
    }
  } else {
    throw Exception('Failed to load music data');
  }
}
