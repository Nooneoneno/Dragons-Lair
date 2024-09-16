import 'package:dragon_lair/entities/video_game_partial.dart';
import 'package:dragon_lair/ui/screens/home_screen/new_release/game_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class NewReleasesWidget extends StatelessWidget {
  final List<VideoGamePartial> games;

  const NewReleasesWidget({super.key, required this.games});

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
            autoPlayInterval: const Duration(seconds: 3),
          ),
          items: games.map((game) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
