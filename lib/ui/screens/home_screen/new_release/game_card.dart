import 'package:dragon_lair/entities/video_game_partial.dart';
import 'package:dragon_lair/ui/screens/game_details_widget/game_details_screen.dart';
import 'package:dragon_lair/ui/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GameCard extends StatelessWidget {
  final VideoGamePartial game;

  const GameCard({super.key, required this.game});

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
      child: AspectRatio(
        aspectRatio: 9 / 21,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: NetworkImageWidget(
                imageUrl: game.coverUrl,
                boxFit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              top: 5,
              left: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      game.releaseDate.day.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 2,
                      height: MediaQuery.of(context).size.height * 0.04,
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    ),
                    Text(
                      DateFormat.MMMM().format(game.releaseDate),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Text(
                  game.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    fontWeight: FontWeight.bold,
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
