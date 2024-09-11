import 'package:DragOnPlay/ui/screens/explore_screen/most_rated_category_widget.dart';
import 'package:DragOnPlay/ui/screens/explore_screen/new_release_category_widget.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  CategoryScreen({required this.categoryId, required this.categoryName});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            widget.categoryName,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              Expanded(child: NewReleasesForCategory()),
              Expanded(child: MostRatedCategory())
            ],
          ),
        ),
      )
    ]);
  }
}
