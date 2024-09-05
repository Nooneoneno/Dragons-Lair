import 'package:GameHub/ui/screens/home_screen/new_release/new_release_widget.dart';
import 'package:GameHub/ui/screens/home_screen/popular_games/popular_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NewReleasesWidget(),
            SizedBox(height: 24),
            PopularWidget(),
          ],
        ),
      );
  }
}