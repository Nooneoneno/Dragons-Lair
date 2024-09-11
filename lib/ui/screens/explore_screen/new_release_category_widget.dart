import 'package:DragOnPlay/controllers/category_controller.dart';
import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:DragOnPlay/ui/screens/explore_screen/new_release_card_widget.dart';
import 'package:flutter/material.dart';

class NewReleasesForCategory extends StatelessWidget {
  final int categoryId;
  final CategoryController categoryController = new CategoryController();

  NewReleasesForCategory({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<VideoGamePartial>>(
      future: categoryController.getNewReleasesForCategory(categoryId),
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
          List<VideoGamePartial> newReleases = snapshot.data!;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'New Releases',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: newReleases.length,
                    itemBuilder: (context, index) {
                      return NewReleaseCard(game: newReleases[index]);
                    },
                  ),
                ),
              ),
            ],
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
