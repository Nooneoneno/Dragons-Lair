import 'package:DragOnPlay/controllers/categories_controller.dart';
import 'package:DragOnPlay/entities/category.dart';
import 'package:DragOnPlay/ui/screens/explore_screen/category_card.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  final CategoriesController categoriesController = CategoriesController();

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<Category> categories = [];

  Future<List<Category>> _fetchCategories() async {
    return await widget.categoriesController.fetchExplore();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: FutureBuilder<List<Category>>(
              future: _fetchCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error fetching categories: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No categories available'),
                  );
                } else {
                  final categories = snapshot.data!;

                  return CustomScrollView(
                    slivers: [
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 1,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final category = categories[index];
                            return GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Selected: ${category.name}')),
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
              },
            ))
          ],
        ));
  }
}
