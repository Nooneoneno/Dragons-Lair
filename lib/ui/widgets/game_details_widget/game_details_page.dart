import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:progetto_esame/controllers/game_fetch_controller.dart';
import 'package:progetto_esame/entities/video_game.dart';
import 'package:progetto_esame/ui/screens/expandable_text_widget.dart';
import 'package:progetto_esame/ui/widgets/game_details_widget/expansion_list_widget.dart';
import 'package:progetto_esame/ui/widgets/game_details_widget/genre_row_widget.dart';
import 'package:progetto_esame/ui/widgets/game_details_widget/language_row_widget.dart';
import 'package:progetto_esame/ui/widgets/game_details_widget/platform_row_widget.dart';
import 'package:progetto_esame/ui/widgets/game_details_widget/storyline_widget.dart';

class GameDetailsPage extends StatefulWidget {
  final int gameId;

  GameDetailsPage({required this.gameId});

  @override
  _GameDetailsPageState createState() => _GameDetailsPageState();
}

class _GameDetailsPageState extends State<GameDetailsPage> {
  late Future<VideoGame> _gameFuture;

  @override
  void initState() {
    super.initState();
    _gameFuture = _fetchGame();
  }

  Future<VideoGame> _fetchGame() {
    return GameFetchController().getGame(widget.gameId);
  }

  void _navigateToGameDetails(BuildContext context, int gameId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => GameDetailsPage(gameId: gameId)),
    );
  }

  void _retryFetching() {
    setState(() {
      _gameFuture = _fetchGame();
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
            future: GameFetchController().getGame(widget.gameId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.redAccent,
                        size: 60,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Oops!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Something went wrong while loading the game info.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white12,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        icon: Icon(Icons.refresh, color: Colors.white),
                        label: Text(
                          'Retry',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        onPressed: () {
                          _retryFetching();
                        },
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasData) {
                final game = snapshot.data!;

                final List combinedGenresAndThemes = List.from(game.genres)
                  ..addAll(game.themes);
                return Stack(children: [
                  game.coverUrl.isNotEmpty
                      ? Image.network(
                          game.coverUrl,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/placeholder.jpg',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2),
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                  DraggableScrollableSheet(
                    initialChildSize: 0.33,
                    minChildSize: 0.33,
                    maxChildSize: 1,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        padding: EdgeInsets.all(16.0),
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              controller: scrollController,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          game.name,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                                Icons.favorite_border_outlined,
                                                color: Colors.white),
                                            onPressed: () {},
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.playlist_add,
                                                color: Colors.white),
                                            onPressed: () {
                                              Fluttertoast.showToast(
                                                msg:
                                                    "Game added to your library!",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.TOP,
                                                backgroundColor: Colors.white,
                                                textColor: Colors.black87,
                                                fontSize: 16.0,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  RichText(
                                      text: TextSpan(
                                          text: 'Release Date: ',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 18,
                                          ),
                                          children: [
                                        TextSpan(
                                            text: DateFormat.yMMMMd().format(
                                                game.humanFirstReleaseDate),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ])),
                                  SizedBox(height: 16),
                                  if (game.summary.isNotEmpty)
                                    Column(
                                      children: [
                                        ExpandableText(
                                            text: game.summary, maxLines: 2),
                                        SizedBox(height: 16),
                                      ],
                                    ),
                                  GenreRow(genres: combinedGenresAndThemes),
                                  SizedBox(height: 8),
                                  PlatformRow(platforms: game.platforms),
                                  if (game.storyline.isNotEmpty)
                                    StorylineText(storyline: game.storyline),
                                  if (game.languageSupports.isNotEmpty)
                                    SupportedLanguages(
                                        languages: game.languageSupports),
                                  SizedBox(height: 16),
                                  if (game.dlcs
                                      .isNotEmpty)
                                    GameExpansionList(
                                        title: "DLCs",
                                        gameIds: game.dlcs,
                                        onGameTap: (dlcId) =>
                                            _navigateToGameDetails(
                                                context, dlcId)),
                                  if (game.remakes.isNotEmpty)
                                    GameExpansionList(
                                        title: "Remakes",
                                        gameIds: game.remakes,
                                        onGameTap: (gameId) =>
                                            _navigateToGameDetails(
                                                context, gameId)),
                                  if (game.remasters.isNotEmpty)
                                    GameExpansionList(
                                        title: "Remasters",
                                        gameIds: game.remasters,
                                        onGameTap: (gameId) =>
                                            _navigateToGameDetails(
                                                context, gameId)),
                                  if (game.parentGame != 0)
                                    GameExpansionList(
                                        title: "Main game",
                                        gameIds: [game.parentGame],
                                        onGameTap: (parentId) =>
                                            _navigateToGameDetails(
                                                context, parentId)),
                                ],
                              ),
                            ),
                            Positioned(
                              top: -5,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                ),
                                child: Center(
                                  child: Container(
                                    width: 40,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Colors.white54,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ]);
              }
              return Center(child: Text('ERROR: No game data found'));
            }));
  }
}
