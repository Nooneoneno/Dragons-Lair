import 'package:flutter/material.dart';
import 'package:progetto_esame/ui/screens/home_screen/new_release/new_release_widget.dart';
import 'package:progetto_esame/ui/screens/home_screen/popular_widget.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NewReleasesWidget(),
            SizedBox(height: 20),
            PopularWidget(),
          ],
        ),
      ),
    );
  }
}