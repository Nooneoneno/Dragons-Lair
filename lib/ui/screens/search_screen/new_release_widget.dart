import 'package:flutter/material.dart';
import 'package:progetto_esame/entities/video_game.dart';
import 'package:progetto_esame/ui/screens/search_screen/game_card.dart';

class NewReleasesWidget extends StatelessWidget {
  final List<VideoGame> games = [
    VideoGame(
        name: 'The Last of Us Part II',
        genre: 'Action',
        online: 'Co-op',
        publisher: 'Bethesda',
        referenceStore: 'Steam',
        releaseDate: DateTime.now()
    ),
    VideoGame(
        name: 'Cyberpunk 2077',
        genre: 'RPG',
        online: 'Co-op',
        publisher: 'Bethesda',
        referenceStore: 'Steam',
        releaseDate: DateTime.now()
    ),
    VideoGame(
        name: 'Ghost of Tsushima',
        genre: 'Action',
        online: 'Co-op',
        publisher: 'Bethesda',
        referenceStore: 'Steam',
        releaseDate: DateTime.now()
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nuove Uscite',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 350,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: games.length,
              itemBuilder: (context, index) {
                return GameCard(game: games[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
