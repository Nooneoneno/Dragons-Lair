import 'dart:ui';

import 'package:DragOnPlay/entities/video_game.dart';
import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:DragOnPlay/controllers/hive_controller.dart';
import 'package:DragOnPlay/ui/screens/expandable_text_widget.dart';
import 'package:DragOnPlay/ui/widgets/game_details_widget/expansion_list_widget.dart';
import 'package:DragOnPlay/ui/widgets/game_details_widget/game_details_page.dart';
import 'package:DragOnPlay/ui/widgets/game_details_widget/genre_row_widget.dart';
import 'package:DragOnPlay/ui/widgets/game_details_widget/language_row_widget.dart';
import 'package:DragOnPlay/ui/widgets/game_details_widget/platform_row_widget.dart';
import 'package:DragOnPlay/ui/widgets/game_details_widget/storyline_widget.dart';
import 'package:DragOnPlay/ui/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GameInfo extends StatelessWidget {
  final VideoGame game;

  const GameInfo({super.key, required this.game});

  void _navigateToGameDetails(BuildContext context, int gameId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameDetailsPage(gameId: gameId)),
    );
  }

  void addGameToLibrary() async {
    await HiveController.addGameToLibrary(VideoGamePartial(
        id: game.id,
        name: game.name,
        coverUrl: game.coverUrl,
        firstReleaseDate: game.firstReleaseDate,
        releaseDate: game.humanFirstReleaseDate,
        rating: 4));
  }

  @override
  Widget build(BuildContext context) {
    final List combinedGenresAndThemes = List.from(game.genres)
      ..addAll(game.themes);

    return Stack(children: [
      NetworkImageWidget(
        imageUrl: game.coverUrl,
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
        maxChildSize: 1,
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
            child: Stack(
              children: [
                SingleChildScrollView(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.favorite_border_outlined,
                                    color: Colors.white),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.playlist_add,
                                    color: Colors.white),
                                onPressed: () async {
                                  addGameToLibrary();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            '${game.name} aggiunto alla libreria!')),
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
                                text: DateFormat.yMMMMd()
                                    .format(game.humanFirstReleaseDate),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ])),
                      SizedBox(height: 16),
                      if (game.summary.isNotEmpty)
                        Column(
                          children: [
                            ExpandableText(text: game.summary, maxLines: 2),
                            SizedBox(height: 16),
                          ],
                        ),
                      GenreRow(genres: combinedGenresAndThemes),
                      SizedBox(height: 8),
                      PlatformRow(platforms: game.platforms),
                      if (game.storyline.isNotEmpty)
                        StorylineText(storyline: game.storyline),
                      if (game.languageSupports.isNotEmpty)
                        SupportedLanguages(languages: game.languageSupports),
                      SizedBox(height: 16),
                      if (game.dlcs.isNotEmpty)
                        GameExpansionList(
                            title: "DLCs",
                            gameIds: game.dlcs,
                            onGameTap: (dlcId) =>
                                _navigateToGameDetails(context, dlcId)),
                      if (game.remakes.isNotEmpty)
                        GameExpansionList(
                            title: "Remakes",
                            gameIds: game.remakes,
                            onGameTap: (gameId) =>
                                _navigateToGameDetails(context, gameId)),
                      if (game.remasters.isNotEmpty)
                        GameExpansionList(
                            title: "Remasters",
                            gameIds: game.remasters,
                            onGameTap: (gameId) =>
                                _navigateToGameDetails(context, gameId)),
                      if (game.parentGame != 0)
                        GameExpansionList(
                            title: "Main game",
                            gameIds: [game.parentGame],
                            onGameTap: (parentId) =>
                                _navigateToGameDetails(context, parentId)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ]);
  }
}
