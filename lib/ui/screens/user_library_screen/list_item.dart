import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:DragOnPlay/ui/screens/game_details_widget/game_details_screen.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final VideoGamePartial game;
  final Function(int) onRemoveGame;

  const ListItem({super.key, required this.game, required this.onRemoveGame});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameDetailsPage(gameId: game.id),
          ),
        );
      },
      child: Container(
        height: 100,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: game.coverUrl.isNotEmpty
                ? NetworkImage(game.coverUrl)
                : AssetImage('assets/placeholder.jpg') as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.3),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Text(
                game.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () async {
                  onRemoveGame(game.id);
                },
                child: Container(
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.redAccent.withOpacity(0.9),
                  ),
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
