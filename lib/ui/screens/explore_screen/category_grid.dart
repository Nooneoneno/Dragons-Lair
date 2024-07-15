import 'package:flutter/material.dart';
import 'package:progetto_esame/entities/category.dart';
import 'package:progetto_esame/ui/screens/explore_screen/category_card.dart';

class CategoryGrid extends StatelessWidget {
  final List<VideoGameCategory> categories = [
    VideoGameCategory(
        name: 'Action',
        slug: 'action',
        image: 'assets/categories_bg/action.jpg'),
    VideoGameCategory(
        name: 'Adventure', slug: 'adventure', image: 'assets/placeholder.jpg'),
    VideoGameCategory(
        name: 'RPG', slug: 'rpg', image: 'assets/placeholder.jpg'),
    VideoGameCategory(
        name: 'Strategy', slug: 'strategy', image: 'assets/placeholder.jpg'),
    VideoGameCategory(
        name: 'Indie', slug: 'indie', image: 'assets/placeholder.jpg'),
    VideoGameCategory(
        name: 'Arcade', slug: 'arcade', image: 'assets/placeholder.jpg'),
    VideoGameCategory(
        name: 'Visual Novel',
        slug: 'visual-novel',
        image: 'assets/placeholder.jpg'),
  ];

  CategoryGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return CategoryCard(categoryName: categories[index].name, categoryImage: categories[index].image);
      },
    );
  }
}
