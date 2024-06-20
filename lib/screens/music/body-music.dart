import 'package:flutter/material.dart';
import 'package:movie_from_github/models/musicModel.dart';

class BodyMusic extends StatelessWidget {
  final MusicResult music;

  BodyMusic({required this.music});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            height: 150,
            width: 130,
            child: music.image.isNotEmpty
                ? Image.network(
                    music.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      child: Container(
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
                    ),
                  )
                : const SizedBox(),
          ),
          const SizedBox(height: 5.0),
          Text(
            music.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text('Artist: ${music.artist}'),
          Text('Type: ${music.type}'),
          Text('Release Date: ${music.dateRelease}'),
          Text('Description: ${music.description}'),
          Text('Country: ${music.country}'),
          Text('Rating: ${music.rating}'),
          Text('Link: ${music.link}'),
          Text('Views: ${music.views}'),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
