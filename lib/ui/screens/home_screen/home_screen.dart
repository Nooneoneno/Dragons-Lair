import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:DragOnPlay/ui/screens/home_screen/new_release/new_release_widget.dart';
import 'package:DragOnPlay/ui/screens/home_screen/popular_games/popular_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  final Future<void> Function() fetchGames;
  final List<VideoGamePartial> newReleases;
  final List<VideoGamePartial> popularGames;

  HomeScreen({
    super.key,
    required this.fetchGames,
    required this.newReleases,
    required this.popularGames,
  });

  void _scrollListener() {
    if (_scrollController.offset <= _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      fetchGames();
    }
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(_scrollListener);

    return RefreshIndicator(
      onRefresh: fetchGames,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NewReleasesWidget(games: newReleases),
            SizedBox(height: 24),
            PopularWidget(games: popularGames),
          ],
        ),
      ),
    );
  }
}
