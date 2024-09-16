import 'package:flutter/material.dart';
import 'package:DragOnPlay/controllers/api_controller.dart';
import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:DragOnPlay/ui/screens/home_screen/new_release/new_release_widget.dart';
import 'package:DragOnPlay/ui/screens/home_screen/popular_games/popular_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiController apiController = ApiController();
  List<VideoGamePartial> newReleases = [];
  List<VideoGamePartial> popularGames = [];
  final ScrollController _scrollController = ScrollController();
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
    _scrollController.addListener(_scrollListener);
  }

  void _fetchInitialData() async {
    await _fetchNewReleases();
    await _fetchPopularGames();
  }

  Future<void> _fetchNewReleases() async {
    if (_isFetching) return;
    setState(() { _isFetching = true; });
    var newGames = await apiController.fetchNewRelease();
    setState(() {
      newReleases = newGames;
      _isFetching = false;
    });
  }

  Future<void> _fetchPopularGames() async {
    if (_isFetching) return;
    setState(() { _isFetching = true; });
    var popGames = await apiController.fetchPopularGames(50, 0);
    setState(() {
      popularGames = popGames;
      _isFetching = false;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // Scrolled to the bottom
      _fetchPopularGames(); // Fetch more popular games or data if needed
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NewReleasesWidget(games: newReleases),
          SizedBox(height: 24),
          PopularWidget(games: popularGames),
        ],
      ),
    );
  }
}
