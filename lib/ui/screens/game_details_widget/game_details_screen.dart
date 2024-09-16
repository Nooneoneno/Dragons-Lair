import 'package:dragon_lair/controllers/api_controller.dart';
import 'package:dragon_lair/entities/video_game.dart';
import 'package:dragon_lair/ui/screens/common_screens/retry_page.dart';
import 'package:dragon_lair/ui/screens/game_details_widget/game_info_widget.dart';
import 'package:flutter/material.dart';

class GameDetailsPage extends StatefulWidget {
  final int gameId;

  const GameDetailsPage({super.key, required this.gameId});

  @override
  _GameDetailsPageState createState() => _GameDetailsPageState();
}

class _GameDetailsPageState extends State<GameDetailsPage> {
  Future<VideoGame> _fetchGame() {
    return ApiController().getGame(widget.gameId);
  }

  void _retryFetching() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder<VideoGame>(
            future: _fetchGame(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  decoration: const BoxDecoration(color: Colors.black),
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
                );
              } else if (snapshot.hasError) {
                return RetryPage(retryFetching: _retryFetching);
              } else if (snapshot.hasData) {
                final game = snapshot.data!;
                return GameInfo(
                  game: game,
                );
              }
              return Container(
                decoration: const BoxDecoration(color: Colors.black),
                child: const Center(
                    child: Text(
                  'ERROR: No game data found',
                  style: TextStyle(color: Colors.white),
                )),
              );
            }));
  }
}
