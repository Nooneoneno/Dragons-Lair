import 'package:DragOnPlay/controllers/category_controller.dart';
import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:DragOnPlay/ui/screens/explore_screen/new_release_card_widget.dart';
import 'package:DragOnPlay/ui/screens/explore_screen/piedistal_item_widget.dart';
import 'package:flutter/material.dart';

class MostRatedCategory extends StatelessWidget {
  final int categoryId;
  final CategoryController categoryController = new CategoryController();

  MostRatedCategory({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Top Rated',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PiedistalItem(
                        game: mostRated[2], height: 130.0, position: 2),
                    PiedistalItem(
                        game: mostRated[0], height: 150.0, position: 1),
                    PiedistalItem(
                        game: mostRated[1], height: 120.0, position: 3),
                  ],
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
