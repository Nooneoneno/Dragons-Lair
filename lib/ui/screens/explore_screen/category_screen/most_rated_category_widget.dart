import 'package:dragon_lair/controllers/api_controller.dart';
import 'package:dragon_lair/entities/video_game_partial.dart';
import 'package:dragon_lair/ui/screens/explore_screen/category_screen/horizontal_game_card_with_rating_widget.dart';
import 'package:flutter/material.dart';

class MostRatedCategory extends StatelessWidget {
  final ApiController apiController = ApiController();
  final int categoryId;

  MostRatedCategory({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder<List<VideoGamePartial>>(
      future: apiController.getMostRated(categoryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          ));
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(
              'Failed to load new releases. Please check your connection.',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const Center(
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
                const Text(
                  '''Critics' Top Rated''',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: (screenHeight * 0.4) + (6 * 8),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: mostRated.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: HorizontalGameCardWithRating(
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
          return const Center(
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
