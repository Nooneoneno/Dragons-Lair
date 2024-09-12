import 'package:DragOnPlay/controllers/category_controller.dart';
import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:flutter/material.dart';

class MostRatedCategory extends StatelessWidget {
  final int categoryId;
  final CategoryController categoryController = CategoryController();

  MostRatedCategory({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder<List<VideoGamePartial>>(
      future: categoryController.getMostRated(categoryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Failed to load new releases. Please check your connection.',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'No new releases available for this category.',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        } else if (snapshot.hasData) {
          List<VideoGamePartial> mostRated = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Top Rated',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: (screenHeight * 0.5) + (8 * 8),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: mostRated.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: HorizontalGameCard(
                          game: mostRated[index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Text(
              'Something went wrong.',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        }
      },
    );
  }
}

class HorizontalGameCard extends StatelessWidget {
  final VideoGamePartial game;

  const HorizontalGameCard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width;
    double cardHeight = MediaQuery.of(context).size.height * 0.1;

    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Stack(
              children: [
                Image.network(
                  game.coverUrl,
                  fit: BoxFit.cover,
                  width: cardWidth,
                  height: cardHeight,
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              game.name,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Text(
              'Rating: ${4.5}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
