import 'package:flutter/material.dart';
import 'package:progetto_esame/ui/screens/explore_screen/explore_grid_cell.dart';

class ExploreGrid extends StatelessWidget {
  ExploreGrid({super.key});

  final List<Map<String, String>> categories = [
    {'name': 'Action', 'image': 'assets/categories_bg/action.jpg'},
    {'name': 'Adventure', 'image': 'assets/adventure.jpg'},
    {'name': 'RPG', 'image': 'assets/rpg.jpg'},
    {'name': 'Strategy', 'image': 'assets/strategy.jpg'},
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
        return ExploreGridCell(categoryName: category['name']!, categoryImage: category['image']!);
      },
    ));
  }
}
