import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:DragOnPlay/ui/widgets/game_details_widget/game_details_page.dart';
import 'package:flutter/material.dart';

class PiedistalItem extends StatelessWidget {
  final int position;
  final double height;
  final VideoGamePartial game;
  const PiedistalItem({super.key, required this.game, required this.height, required this.position});

  @override
  Widget build(BuildContext context) {
    String positionText;
    Color positionColor;

    switch (position) {
      case 1:
        positionText = '1st';
        positionColor = Colors.amber;
        break;
      case 2:
        positionText = '2nd';
        positionColor = Colors.white54;
        break;
      case 3:
        positionText = '3rd';
        positionColor = Colors.brown;
        break;
      default:
        positionText = '';
        positionColor = Colors.white;
    }

    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GameDetailsPage(gameId: game.id)),
        );
      },
      child: Column(
        children: [
          Text(
            positionText,
            style: TextStyle(
              color: positionColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: height,
            width: 100,
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
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
