import 'package:flutter/material.dart';
import 'package:movie_from_github/screens/music/body-music.dart';
import 'package:movie_from_github/service/music-service.dart';
import '../../models/musicModel.dart';

class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  late Future<MusicModel> futureMusicData;

  @override
  void initState() {
    super.initState();
    futureMusicData = fetchMusicData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<MusicModel>(
          future: futureMusicData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return Text('No data found');
            } else {
              final musicList = snapshot.data!.results;
              return ListView.builder(
                itemCount: musicList.length,
                itemBuilder: (context, index) {
                  return BodyMusic(music: musicList[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
