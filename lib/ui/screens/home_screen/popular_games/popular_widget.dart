import 'package:flutter/material.dart';
import 'package:dragon_lair/controllers/api_controller.dart';
import 'package:dragon_lair/entities/video_game_partial.dart';
import 'package:dragon_lair/ui/screens/home_screen/popular_games/horizontal_game_card.dart';

class PopularWidget extends StatefulWidget {
  final List<VideoGamePartial> games;
  final ApiController apiController = ApiController();

  PopularWidget({super.key, required this.games});

  @override
  _PopularWidgetState createState() => _PopularWidgetState();
}

class _PopularWidgetState extends State<PopularWidget> {
  int currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPage);
  }

  void _handlePageChange(int page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    int itemsPerPage = 10;
    int totalPages = (widget.games.length / itemsPerPage).ceil();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Games',
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
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (notification is OverscrollNotification) {
                _pageController.position.jumpTo(
                  _pageController.position.pixels + notification.overscroll,
                );
              }
              return false;
            },
            child: PageView.builder(
              controller: _pageController,
              itemCount: totalPages,
              onPageChanged: _handlePageChange,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, pageIndex) {
                int startIndex = pageIndex * itemsPerPage;
                int endIndex = (startIndex + itemsPerPage > widget.games.length)
                    ? widget.games.length
                    : startIndex + itemsPerPage;

                List<VideoGamePartial> currentGames = widget.games.sublist(startIndex, endIndex);

                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double value = 1.0;
                    if (_pageController.position.haveDimensions) {
                      value = _pageController.page! - pageIndex;
                      value = (1 - (value.abs() * 0.3)).clamp(0.7, 1.0);
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
                            child:
                                HorizontalGameCard(game: currentGames[index]),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
