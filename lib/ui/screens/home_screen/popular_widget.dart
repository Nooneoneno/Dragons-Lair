import 'package:flutter/material.dart';
import 'package:progetto_esame/entities/video_game.dart';
import 'package:progetto_esame/ui/screens/home_screen/horizontal_game_card.dart';

class PopularWidget extends StatelessWidget {
  final List<VideoGame> games = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popolari',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 350,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: games.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: HorizontalGameCard(game: games[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
