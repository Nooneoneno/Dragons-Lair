import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:progetto_esame/entities/video_game.dart';
import 'package:progetto_esame/ui/screens/home_screen/game_card.dart';

class NewReleasesWidget extends StatefulWidget {
  final List<VideoGame> games = [
    VideoGame(
      name: 'The Last of Us Part II',
      genre: 'Action',
      online: 'Co-op',
      publisher: 'Bethesda',
      referenceStore: 'Steam',
      releaseDate: DateTime.now(),
    ),
    VideoGame(
      name: 'Cyberpunk 2077',
      genre: 'RPG',
      online: 'Co-op',
      publisher: 'Bethesda',
      referenceStore: 'Steam',
      releaseDate: DateTime.now(),
    ),
    VideoGame(
      name: 'Ghost of Tsushima',
      genre: 'Action',
      online: 'Co-op',
      publisher: 'Bethesda',
      referenceStore: 'Steam',
      releaseDate: DateTime.now(),
    ),
    VideoGame(
      name: 'Manor Lords',
      genre: 'Action',
      online: 'Co-op',
      publisher: 'Bethesda',
      referenceStore: 'Steam',
      releaseDate: DateTime.now(),
    ),
    VideoGame(
      name: 'Grand Theft Auto V',
      genre: 'Action',
      online: 'Co-op',
      publisher: 'Bethesda',
      referenceStore: 'Steam',
      releaseDate: DateTime.now(),
    )
  ];

  @override
  _NewReleasesWidgetState createState() => _NewReleasesWidgetState();
}

class _NewReleasesWidgetState extends State<NewReleasesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nuove Uscite',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        CarouselSlider(
          options: CarouselOptions(
            height: 350.0,
            initialPage: 0,
            autoPlay: true,
            viewportFraction: 0.75,
            aspectRatio: 16/9,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayInterval: Duration(seconds: 3),
          ),
          items: widget.games.map((i) {
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
