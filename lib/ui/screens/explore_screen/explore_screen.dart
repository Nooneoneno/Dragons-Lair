import 'package:DragOnPlay/entities/category.dart';
import 'package:DragOnPlay/ui/screens/explore_screen/category_card.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  final List<Category> categories = [
    Category(name: "Action", imageUrl: "https://example.com/action.jpg"),
    Category(name: "Adventure", imageUrl: "https://example.com/adventure.jpg"),
    Category(name: "RPG", imageUrl: "https://example.com/rpg.jpg"),
    Category(name: "Sports", imageUrl: "https://example.com/sports.jpg"),
    Category(name: "Shooter", imageUrl: "https://example.com/shooter.jpg"),
    Category(name: "Strategy", imageUrl: "https://example.com/strategy.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(16.0),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Explore Categories',
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.75,
          ),
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected: ${category.name}')),
                  );
                },
                child: CategoryCard(category: category),
              );
            },
            childCount: categories.length,
          ),
        ),
      ],
    );
  }
}
