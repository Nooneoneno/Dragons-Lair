import 'package:DragOnPlay/controllers/api_controller.dart';
import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:DragOnPlay/ui/screens/home_screen/new_release/new_release_widget.dart';
import 'package:DragOnPlay/ui/screens/home_screen/popular_games/popular_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiController apiController = ApiController();
  List<VideoGamePartial> newReleases = [];
  List<VideoGamePartial> popularGames = [];

  @override
  void initState() {
    super.initState();
    _fetchNewReleases();
    _fetchPopularGames();
  }

  void _fetchNewReleases() async {
    var newGames = await apiController.fetchNewRelease();
    setState(() {
      newReleases = newGames;
    });
  }

  void _fetchPopularGames() async{
    var popGames = await apiController.fetchPopularGames(50, 0);
    setState(() {
      popularGames = popGames;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NewReleasesWidget(games: newReleases,),
            SizedBox(height: 24),
            PopularWidget(games: popularGames,),
          ],
        ),
      );
  }
}