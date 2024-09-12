import 'package:DragOnPlay/controllers/catalog_controller.dart';
import 'package:DragOnPlay/ui/screens/explore_screen/catalog_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:DragOnPlay/entities/video_game_partial.dart';

class GameCatalog extends StatefulWidget {
  final CatalogController catalogController = CatalogController();
  final int categoryId;
  GameCatalog({super.key, required this.categoryId});

  @override
  _GameCatalogState createState() => _GameCatalogState();
}

class _GameCatalogState extends State<GameCatalog> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _fetchGames();
  }

  Future<List<VideoGamePartial>> _fetchGames() async {

    List<VideoGamePartial> fetchedGames = await widget.catalogController.getCatalog(widget.categoryId);

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
                    'Failed to load new releases. Please check your connection.',
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

                return Container(
                    constraints: BoxConstraints(
                      maxHeight: screenHeight * 0.6,
                    ),
                    child: PageView.builder(
                        controller: _pageController,
                        itemCount: totalPages,
                        onPageChanged: _handlePageChange,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, pageIndex) {
                          int startIndex = pageIndex * itemsPerPage;
                          int endIndex =
                              (startIndex + itemsPerPage > games.length)
                                  ? games.length
                                  : startIndex + itemsPerPage;

                          List<VideoGamePartial> currentGames =
                              games.sublist(startIndex, endIndex);

                          return AnimatedBuilder(
                            animation: _pageController,
                            builder: (context, child) {
                              double value = 1.0;
                              if (_pageController.position.haveDimensions) {
                                value = _pageController.page! - pageIndex;
                                value =
                                    (1 - (value.abs() * 0.3)).clamp(0.7, 1.0);
                              }

                              return Transform.scale(
                                scale: value,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: currentGames.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: screenHeight * 0.01),
                                      child: CatalogItem(
                                          game: currentGames[index]),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        }));
              }
            },
          ),
        ],
      ),
    );
  }
}
