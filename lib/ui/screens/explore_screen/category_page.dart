import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final String categoryName;

  CategoryPage({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryName,
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Center(
        child: Text('Questa è la pagina per $categoryName'),
      ),
    );
  }
}