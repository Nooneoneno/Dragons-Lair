import 'dart:ui';

import 'package:DragOnPlay/controllers/storage_controller.dart';
import 'package:DragOnPlay/entities/video_game.dart';
import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:DragOnPlay/ui/screens/game_details_widget/expansion_list_widget.dart';
import 'package:DragOnPlay/ui/screens/game_details_widget/game_details_screen.dart';
import 'package:DragOnPlay/ui/screens/game_details_widget/genre_row_widget.dart';
import 'package:DragOnPlay/ui/screens/game_details_widget/language_row_widget.dart';
import 'package:DragOnPlay/ui/screens/game_details_widget/platform_row_widget.dart';
import 'package:DragOnPlay/ui/screens/game_details_widget/storyline_widget.dart';
import 'package:DragOnPlay/ui/widgets/expandable_text_widget.dart';
import 'package:DragOnPlay/ui/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GameInfo extends StatefulWidget {
  final VideoGame game;

  const GameInfo({super.key, required this.game});

  @override
  _GameInfoState createState() => _GameInfoState();
}

class _GameInfoState extends State<GameInfo> {
  bool isInFavourite = false;
  bool isInLibrary = false;

  @override
  void initState() {
    super.initState();
    _checkGameState();
  }

  void _navigateToGameDetails(BuildContext context, int gameId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameDetailsPage(gameId: gameId)),
    );
  }

  void _checkGameState() async {
    bool inLibrary = await HiveController.isGameInLibrary(widget.game.id);
    bool inFavourite = await HiveController.isGameInFavourite(widget.game.id);
    setState(() {
      isInFavourite = inFavourite;
      isInLibrary = inLibrary;
    });
  }

  void _toggleGameInFavourite() async {
    if (isInFavourite) {
      await HiveController.removeGameFromFavourite(widget.game.id);
    } else {
      await HiveController.addGameToFavourite(VideoGamePartial(
        id: widget.game.id,
        name: widget.game.name,
        coverUrl: widget.game.coverUrl,
        firstReleaseDate: widget.game.firstReleaseDate,
        releaseDate: widget.game.humanFirstReleaseDate,
        rating: 4,
      ));
    }

    setState(() {
      isInFavourite = !isInFavourite;
    });
  }

  void _toggleGameInLibrary() async {
    if (isInLibrary) {
      await HiveController.removeGameFromLibrary(widget.game.id);
    } else {
      await HiveController.addGameToLibrary(VideoGamePartial(
        id: widget.game.id,
        name: widget.game.name,
        coverUrl: widget.game.coverUrl,
        firstReleaseDate: widget.game.firstReleaseDate,
        releaseDate: widget.game.humanFirstReleaseDate,
        rating: 4,
      ));
    }

    setState(() {
      isInLibrary = !isInLibrary;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List combinedGenresAndThemes = List.from(widget.game.genres)
      ..addAll(widget.game.themes);

    return Stack(children: [
      NetworkImageWidget(
        imageUrl: widget.game.coverUrl,
        width: double.infinity,
        height: double.infinity,
        boxFit: BoxFit.cover,
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
        maxChildSize: 0.88,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
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
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.game.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                    scale: animation, child: child);
                              },
                              child: Icon(
                                isInFavourite
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                key: ValueKey<bool>(isInFavourite),
                                color: isInFavourite
                                    ? Colors.pinkAccent
                                    : Colors.white,
                              ),
                            ),
                            onPressed: _toggleGameInFavourite,
                          ),
                          IconButton(
                            icon: AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                    scale: animation, child: child);
                              },
                              child: Icon(
                                isInLibrary
                                    ? Icons.playlist_remove
                                    : Icons.playlist_add,
                                key: ValueKey<bool>(isInLibrary),
                                color: isInLibrary
                                    ? Colors.redAccent
                                    : Colors.green,
                              ),
                            ),
                            onPressed: _toggleGameInLibrary,
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
                            text: DateFormat.yMMMMd()
                                .format(widget.game.humanFirstReleaseDate),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ])),
                  SizedBox(height: 16),
                  if (widget.game.summary.isNotEmpty)
                    Column(
                      children: [
                        ExpandableText(text: widget.game.summary, maxLines: 4),
                        SizedBox(height: 16),
                      ],
                    ),
                  GenreRow(genres: combinedGenresAndThemes),
                  SizedBox(height: 8),
                  PlatformRow(platforms: widget.game.platforms),
                  if (widget.game.storyline.isNotEmpty)
                    StorylineText(storyline: widget.game.storyline),
                  if (widget.game.languageSupports.isNotEmpty)
                    SupportedLanguages(languages: widget.game.languageSupports),
                  SizedBox(height: 16),
                  if (widget.game.dlcs.isNotEmpty)
                    GameExpansionList(
                        title: "DLCs",
                        gameIds: widget.game.dlcs,
                        onGameTap: (dlcId) =>
                            _navigateToGameDetails(context, dlcId)),
                  if (widget.game.remakes.isNotEmpty)
                    GameExpansionList(
                        title: "Remakes",
                        gameIds: widget.game.remakes,
                        onGameTap: (gameId) =>
                            _navigateToGameDetails(context, gameId)),
                  if (widget.game.remasters.isNotEmpty)
                    GameExpansionList(
                        title: "Remasters",
                        gameIds: widget.game.remasters,
                        onGameTap: (gameId) =>
                            _navigateToGameDetails(context, gameId)),
                  if (widget.game.parentGame != 0)
                    GameExpansionList(
                        title: "Main game",
                        gameIds: [widget.game.parentGame],
                        onGameTap: (parentId) =>
                            _navigateToGameDetails(context, parentId)),
                ],
              ),
            ),
          );
        },
      ),
    ]);
  }
}
