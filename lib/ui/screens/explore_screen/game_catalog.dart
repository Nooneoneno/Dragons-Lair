import 'package:DragOnPlay/ui/screens/home_screen/popular_games/horizontal_game_card.dart';
import 'package:flutter/material.dart';
import 'package:DragOnPlay/entities/video_game_partial.dart';

class GameCatalog extends StatefulWidget {
  GameCatalog({Key? key}) : super(key: key);

  @override
  _GameCatalogState createState() => _GameCatalogState();
}

class _GameCatalogState extends State<GameCatalog> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  Future<List<VideoGamePartial>> _fetchGames() async {
    await Future.delayed(Duration(seconds: 2));

    List<VideoGamePartial> fetchedGames = List.generate(
      50,
          (index) => VideoGamePartial(
        id: index,
        name: 'Game ${index + 1}',
        coverUrl: 'https://via.placeholder.com/150',
        firstReleaseDate: 0,
        releaseDate: DateTime(2022),
        rating: 95,
      ),
    );

    if (fetchedGames.isEmpty) {
      return [];
    }

    return fetchedGames;
  }

  void _handlePageChange(int page) {
    // handle fetching in case there are other games
  }

  @override
  Widget build(BuildContext context) {
    int itemsPerPage = 10;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Catalogo",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 8),
          FutureBuilder<List<VideoGamePartial>>(
            future: _fetchGames(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'EFailed to load new releases. Please check your connection.',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'No games available for this category.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              } else {
                List<VideoGamePartial> games = snapshot.data!;
                int totalPages = (games.length / itemsPerPage).ceil();

                return SizedBox(
                  height: screenHeight * 0.88,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: totalPages,
                    onPageChanged: _handlePageChange,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, pageIndex) {
                      int startIndex = pageIndex * itemsPerPage;
                      int endIndex = (startIndex + itemsPerPage > games.length)
                          ? games.length
                          : startIndex + itemsPerPage;

                      List<VideoGamePartial> currentGames =
                      games.sublist(startIndex, endIndex);

                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: currentGames.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.01),
                            child: HorizontalGameCard(
                              game: currentGames[index],
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
