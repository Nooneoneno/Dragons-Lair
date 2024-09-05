import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progetto_esame/entities/video_game_partial.dart';
import 'package:progetto_esame/ui/widgets/game_details_widget/game_details_page.dart';
import 'package:progetto_esame/ui/widgets/network_image_widget.dart';

class GameCard extends StatelessWidget {
  final VideoGamePartial game;

  GameCard({required this.game});

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
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: game.coverUrl.isNotEmpty
                  ? NetworkImage(game.coverUrl)
                  : AssetImage('assets/placeholder.jpg') as ImageProvider, //TODO: gestire il caricamento
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 5,
                left: 5,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
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
                      SizedBox(width: 4),
                      Container(
                        width: 2,
                        height: MediaQuery.of(context).size.height * 0.04,
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
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
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(12),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
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
      ),
    );
  }
}
