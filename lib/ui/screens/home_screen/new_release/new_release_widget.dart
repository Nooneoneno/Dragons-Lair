import 'package:DragOnPlay/controllers/api_controller.dart';
import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:DragOnPlay/ui/screens/home_screen/new_release/game_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class NewReleasesWidget extends StatefulWidget {
  final ApiController apiController = ApiController();

  @override
  _NewReleasesWidgetState createState() => _NewReleasesWidgetState();
}

class _NewReleasesWidgetState extends State<NewReleasesWidget> {
  List<VideoGamePartial> games = [];

  @override
  void initState() {
    super.initState();
    _fetchNewReleases();
  }

  void _fetchNewReleases() async {
    var newGames = await widget.apiController.fetchNewRelease();
    setState(() {
      games = newGames;
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
            'New releases',
            style: TextStyle(
              fontSize: screenWidth * 0.06,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: screenHeight * 0.5,
            initialPage: 0,
            autoPlay: true,
            viewportFraction: 0.75,
            aspectRatio: 9 / 21,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayInterval: Duration(seconds: 3),
          ),
          items: games.map((game) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: screenWidth,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: GameCard(game: game),
                    ));
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
