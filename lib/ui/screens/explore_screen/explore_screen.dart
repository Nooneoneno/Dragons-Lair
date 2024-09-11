import 'dart:io';
import 'package:DragOnPlay/ui/screens/explore_screen/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:DragOnPlay/controllers/explore_controller.dart';
import 'package:DragOnPlay/entities/category.dart';
import 'package:DragOnPlay/ui/screens/explore_screen/category_card.dart';

class ExploreScreen extends StatefulWidget {
  final CategoriesController categoriesController = CategoriesController();

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

  void _navigateToCategoryPage(BuildContext context, int categoryId, String categoryName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoryScreen(categoryId: categoryId, categoryName: categoryName,)),
    );
  }

  Future<void> _loadCategories() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
        categories = [];
      });

      List<Category> loadedCategories =
          await widget.categoriesController.fetchCategoriesWithoutImages();
      List<Category> loadedThemes =
          await widget.categoriesController.fetchThemesWithoutImages();

      // If categories is empty handles the error
      if (loadedCategories.isEmpty && loadedThemes.isEmpty) {
        setState(() {
          errorMessage = 'No categories available';
          isLoading = false;
        });
        return;
      }

      setState(() {
        categories = [...loadedCategories, ...loadedThemes];
        isLoading = false;
      });

      _loadImages(loadedCategories, loadedThemes);
      setState(() {
        categories.sort((a, b) => a.name.compareTo(b.name));
      });
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

  Future<void> _loadImages(
      List<Category> loadedCategories, List<Category> loadedThemes) async {
    await for (final updatedCategory
        in widget.categoriesController.fetchCategoryImages(loadedCategories)) {
      setState(() {
        int index =
            categories.indexWhere((cat) => cat.id == updatedCategory.id);
        if (index != -1) {
          categories[index] = updatedCategory;
        }
      });
    }

    await for (final updatedTheme
        in widget.categoriesController.fetchThemeImages(loadedThemes)) {
      setState(() {
        int index = categories.indexWhere((cat) => cat.id == updatedTheme.id);
        if (index != -1) {
          categories[index] = updatedTheme;
        }
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
                            _navigateToCategoryPage(context, category.id, category.name);
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
