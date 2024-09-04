import 'package:flutter/material.dart';
import 'package:progetto_esame/controllers/popular_games_controller.dart';
import 'package:progetto_esame/entities/video_game_partial.dart';
import 'package:progetto_esame/ui/screens/home_screen/popular_games/horizontal_game_card.dart';

class PopularWidget extends StatefulWidget {
  final PopularGamesController popularGamesController = PopularGamesController();

  @override
  _PopularWidgetState createState() => _PopularWidgetState();
}

class _PopularWidgetState extends State<PopularWidget> {
  List<VideoGamePartial> games = [];
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _fetchPopularGames();
  }

  void _fetchPopularGames() async {
    var popularGames = await widget.popularGamesController.fetchNewRelease();
    setState(() {
      games = popularGames;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    int itemsPerPage = 10;
    int totalPages = (games.length / itemsPerPage).ceil();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Giochi Popolari',
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              if (totalPages > 1)
                Text(
                  'Page ${currentPage + 1} of $totalPages',
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: Colors.white70,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: screenHeight * 0.6,
          child: PageView.builder(
            itemCount: totalPages,
            onPageChanged: (page) {
              setState(() {
                currentPage = page;
              });
            },
            itemBuilder: (context, pageIndex) {
              int startIndex = pageIndex * itemsPerPage;
              int endIndex = (startIndex + itemsPerPage > games.length)
                  ? games.length
                  : startIndex + itemsPerPage;

              List<VideoGamePartial> currentGames = games.sublist(startIndex, endIndex);

              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: currentGames.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                    child: HorizontalGameCard(game: currentGames[index]),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
