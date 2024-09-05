import 'dart:ui';

import 'package:GameHub/ui/screens/explore_screen/category_page.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String categoryImage;
  final String categoryName;

  CategoryCard({required this.categoryImage, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryPage(categoryName: categoryName),
            ),
          );
        },
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  categoryImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                    alignment: Alignment.center,
                    child: Text(
                      categoryName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
