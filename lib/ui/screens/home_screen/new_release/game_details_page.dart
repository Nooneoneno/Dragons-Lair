import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:progetto_esame/entities/video_game.dart';
import 'package:progetto_esame/ui/screens/expandable_text_widget.dart';
import 'package:progetto_esame/ui/screens/home_screen/new_release/genre_row_widget.dart';
import 'package:progetto_esame/ui/screens/home_screen/new_release/language_row_widget.dart';
import 'package:progetto_esame/ui/screens/home_screen/new_release/platform_row_widget.dart';
import 'package:progetto_esame/ui/screens/home_screen/new_release/storyline_widget.dart';

class GameDetailsPage extends StatelessWidget {
  final VideoGame game;

  GameDetailsPage({required this.game});

  @override
  Widget build(BuildContext context) {
    final List combinedGenresAndThemes = List.from(game.genres)
      ..addAll(game.themes);
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
        body: Stack(children: [
          game.coverUrl != null && game.coverUrl.isNotEmpty
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
                          SizedBox(
                            height: 25.0,
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
                                    onPressed: () {
                                      Fluttertoast.showToast(
                                        msg: "Game added to your library!",
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
                                    text: DateFormat.yMMMMd()
                                        .format(game.humanFirstReleaseDate),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ])),
                          SizedBox(height: 16),
                          if (game.summary.isNotEmpty)
                            ExpandableText(text: game.summary, maxLines: 2),
                          SizedBox(height: 16),
                          GenreRow(genres: combinedGenresAndThemes),
                          SizedBox(height: 8),
                          PlatformRow(platforms: game.platforms),
                          if (game.storyline.isNotEmpty)
                          StorylineText(storyline: game.storyline),
                          if (game.languageSupports.isNotEmpty)
                          SupportedLanguages(languages: game.languageSupports)
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
        ]));
  }
}
