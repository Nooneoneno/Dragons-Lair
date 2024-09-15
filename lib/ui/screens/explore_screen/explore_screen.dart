import 'dart:io';

import 'package:DragOnPlay/controllers/api_controller.dart';
import 'package:DragOnPlay/entities/category.dart';
import 'package:DragOnPlay/ui/screens/explore_screen/category_card.dart';
import 'package:DragOnPlay/ui/screens/explore_screen/category_screen/category_screen.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  final ApiController apiController = ApiController();

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<Category> categories = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _navigateToCategoryPage(BuildContext context, Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CategoryScreen(
                category: category,
              )),
    );
  }

  Future<void> _loadCategories() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
        categories = [];
      });

      List<Category> loadedCategories = await widget.apiController.getCategoriesName();

      // If categories is empty handles the error
      if (loadedCategories.isEmpty) {
        setState(() {
          errorMessage = 'No categories available';
          isLoading = false;
        });
        return;
      }

      setState(() {
        categories = [...loadedCategories];
        categories.sort((a, b) => a.name.compareTo(b.name));
        isLoading = false;
      });

      _loadImages();
    } on SocketException {
      // Handles the case user is offline
      setState(() {
        errorMessage =
            'No internet connection. Please check your connection and try again.';
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _loadImages() async {
    await for (final updatedCategory
        in widget.apiController.fetchCategoryImages(categories)) {
      setState(() {
        int index = categories.indexWhere((cat) => cat.id == updatedCategory.id);
        categories[index] = updatedCategory;
      });
    }
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
          if (isLoading)
            Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (errorMessage != null)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(errorMessage!),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _loadCategories,
                      child: Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          else if (categories.isEmpty)
            Expanded(
              child: Center(
                child: Text('No categories available'),
              ),
            )
          else
            Expanded(
              child: CustomScrollView(
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
                            _navigateToCategoryPage(context, category);
                          },
                          child: CategoryCard(category: category),
                        );
                      },
                      childCount: categories.length,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
