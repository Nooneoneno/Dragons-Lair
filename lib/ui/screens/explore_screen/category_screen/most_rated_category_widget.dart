import 'package:DragOnPlay/controllers/api_controller.dart';
import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:DragOnPlay/ui/screens/explore_screen/category_screen/horizontal_game_card_with_rating_widget.dart';
import 'package:flutter/material.dart';

class MostRatedCategory extends StatelessWidget {
  final ApiController apiController = ApiController();
  final int categoryId;

  MostRatedCategory({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder<List<VideoGamePartial>>(
      future: apiController.getMostRated(categoryId),
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
                  '''Critics' Top Rated''',
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
                  constraints: BoxConstraints(
                    maxHeight: (screenHeight * 0.4) + (6 * 8),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
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
