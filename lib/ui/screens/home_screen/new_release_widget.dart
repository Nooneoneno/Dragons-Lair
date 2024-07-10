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
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage, viewportFraction: 0.7);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popolari',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 350,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.games.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                  }
                  return Center(
                    child: SizedBox(
                      height: Curves.easeOut.transform(value) * 350,
                      width: Curves.easeOut.transform(value) * 250,
                      child: child,
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: GameCard(game: widget.games[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}