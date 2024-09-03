import 'package:flutter/material.dart';
import 'package:progetto_esame/controllers/new_release_controller.dart';
import 'package:progetto_esame/entities/video_game_partial.dart';
import 'package:progetto_esame/ui/screens/home_screen/horizontal_game_card.dart';
import 'package:progetto_esame/ui/screens/home_screen/new_release/game_card.dart';

class PopularWidget extends StatefulWidget {
  final NewReleaseController newReleaseController = NewReleaseController();

  @override
  _PopularGamesWidgetState createState() => _PopularGamesWidgetState();
}

class _PopularGamesWidgetState extends State<PopularWidget> {
  List<VideoGamePartial> games = [];

  @override
  void initState() {
    super.initState();
    _fetchPopularGames();
  }

  void _fetchPopularGames() async {
    var popularGames = await widget.newReleaseController.fetchNewRelease();
    setState(() {
      games = popularGames;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: Text(
            'Giochi Popolari',
            style: TextStyle(
              fontSize: screenWidth * 0.06,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.5,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: games.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                child: HorizontalGameCard(game: games[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
