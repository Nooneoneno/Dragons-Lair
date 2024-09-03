import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:progetto_esame/controllers/new_release_controller.dart';
import 'package:progetto_esame/entities/video_game_partial.dart';
import 'package:progetto_esame/ui/screens/home_screen/new_release/game_card.dart';

class NewReleasesWidget extends StatefulWidget {
  final NewReleaseController newReleaseController = NewReleaseController();

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
    var newGames = await widget.newReleaseController.fetchNewRelease();
    setState(() {
      games = newGames;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
          child: Text(
            'Nuove uscite',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        SizedBox(height: 10),
        CarouselSlider(
          options: CarouselOptions(
            height: 350.0,
            initialPage: 0,
            autoPlay: true,
            viewportFraction: 0.75,
            aspectRatio: 9 / 21,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayInterval: Duration(seconds: 3),
          ),
          items: games.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: GameCard(game: i),
                    ));
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
