import 'package:dragon_lair/entities/video_game_partial.dart';
import 'package:dragon_lair/ui/screens/game_details_widget/game_details_screen.dart';
import 'package:dragon_lair/ui/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';

class HorizontalGameCardWithRating extends StatelessWidget {
  final VideoGamePartial game;

  const HorizontalGameCardWithRating({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width;
    double cardHeight = MediaQuery.of(context).size.height * 0.1;

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
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                children: [
                  NetworkImageWidget(
                    imageUrl: game.coverUrl,
                    boxFit: BoxFit.cover,
                    width: cardWidth,
                    height: cardHeight,
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                game.name,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Text(
                'Rating: ${game.rating}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
