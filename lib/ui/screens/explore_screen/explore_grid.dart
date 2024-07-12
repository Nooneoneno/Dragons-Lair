import 'package:flutter/material.dart';
import 'package:progetto_esame/entities/category.dart';
import 'package:progetto_esame/ui/screens/explore_screen/explore_grid_cell.dart';

class ExploreGrid extends StatelessWidget {
  ExploreGrid({super.key});

  final List<VideoGameCategory> categories = [
    VideoGameCategory(name: 'Action', slug: 'action', image: 'assets/categories_bg/action.jpg'),
    VideoGameCategory(name: 'Adventure', slug: 'adventure', image: 'assets/categories_bg/action.jpg'),
    VideoGameCategory(name: 'RPG', slug: 'rpg', image: 'assets/categories_bg/action.jpg'),
    VideoGameCategory(name: 'Strategy', slug: 'strategy', image: 'assets/categories_bg/action.jpg'),
    VideoGameCategory(name: 'Indie', slug: 'indie', image: 'assets/categories_bg/action.jpg'),
    VideoGameCategory(name: 'Arcade', slug: 'arcade', image: 'assets/categories_bg/action.jpg'),
    VideoGameCategory(name: 'Visual Novel', slug: 'visual-novel', image: 'assets/categories_bg/action.jpg'),
    // Aggiungi altre categorie qui
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return ExploreGridCell(categoryName: category.name, categoryImage: category.image);
      },
    ));
  }
}
