import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:flutter/material.dart';

class NewReleaseCard extends StatelessWidget {
  final VideoGamePartial game;

  const NewReleaseCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0),
      child: Container(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: game.coverUrl.isNotEmpty
                      ? NetworkImage(game.coverUrl)
                      : AssetImage('assets/placeholder.jpg') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              game.name,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
