import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progetto_esame/entities/video_game_partial.dart';
import 'package:progetto_esame/ui/screens/home_screen/new_release//game_details_page.dart';

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
              image: DecorationImage(
                image: game.coverUrl != null && game.coverUrl.isNotEmpty
                    ? NetworkImage(game.coverUrl)
                    : AssetImage('assets/placeholder.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 5,
                  left: 5,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.black54,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          game.releaseDate.day.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              width: 2,
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(horizontal: 8.0),
                              height: 30,
                            ),
                          ],
                        ),
                        Text(
                          DateFormat.MMMM().format(game.releaseDate),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
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
                    color: Colors.black54,
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      game.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
