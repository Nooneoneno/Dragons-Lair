import 'package:flutter/material.dart';

import 'package:progetto_esame/controllers/game_fetch_controller.dart';
import 'package:progetto_esame/entities/video_game.dart';
import 'package:progetto_esame/ui/widgets/game_details_widget/error_page.dart';
import 'package:progetto_esame/ui/widgets/game_details_widget/game_info_widget.dart';

class GameDetailsPage extends StatefulWidget {
  final int gameId;

  GameDetailsPage({required this.gameId});

  @override
  _GameDetailsPageState createState() => _GameDetailsPageState();
}

class _GameDetailsPageState extends State<GameDetailsPage> {
  Future<VideoGame> _fetchGame() {
    return GameFetchController().getGame(widget.gameId);
  }

  void _retryFetching() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.share, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: FutureBuilder<VideoGame>(
            future: _fetchGame(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return ErrorPage(retryFetching: _retryFetching);
              } else if (snapshot.hasData) {
                final game = snapshot.data!;
                return GameInfo(
                  game: game,
                );
              }
              return Center(child: Text('ERROR: No game data found'));
            }));
  }
}
