import 'dart:convert';

import 'package:progetto_esame/api_service/api_service.dart';
import 'package:progetto_esame/entities/new_release_game.dart';
import 'package:progetto_esame/entities/video_game.dart';

class NewReleaseController {
  final ApiService apiService = ApiService(baseUrl: 'https://api.igdb.com/v4');
  List<VideoGame> newReleaseGames = [];

  Future<List<VideoGame>> getNewRelease() async {
    DateTime now = DateTime.now();
    int nowTimestamp = now.millisecondsSinceEpoch ~/ 1000;
    DateTime lastMonday = now.subtract(Duration(days: now.weekday - 1));
    lastMonday = DateTime(lastMonday.year, lastMonday.month, lastMonday.day);
    int lastWeekTimestamp = lastMonday.millisecondsSinceEpoch ~/ 1000;

    String endpoint = "/release_dates";
    String queryParameters =
        "fields *; where date > $lastWeekTimestamp & date < $nowTimestamp & platform = 6; limit 10;";
    String rawResponse =
        await apiService.postRequest(endpoint, queryParameters);

    List<dynamic> jsonResponse = jsonDecode(rawResponse);
    List<NewGameRelease> releases =
        jsonResponse.map((json) => NewGameRelease.fromJson(json)).toList();

    await getGamesList(releases);
    return newReleaseGames;
  }

  Future<void> getGamesList(List<NewGameRelease> newReleases) async {
    for (NewGameRelease release in newReleases) {
      int gameId = release.game;

      String endpoint = "/games";
      String queryParameters =
          "fields id, category, cover, dlcs, expanded_games, expansions, first_release_date, genres, involved_companies, language_supports, multiplayer_modes, name, platforms, release_dates, similar_games, standalone_expansions, status, storyline, summary, themes, version_title; where id = $gameId;";

      String rawResponse =
          await apiService.postRequest(endpoint, queryParameters);
      if (rawResponse.isNotEmpty) {
        List<dynamic> jsonResponse = jsonDecode(rawResponse);

        if (jsonResponse.isNotEmpty) {
          var gameData = jsonResponse[0];
          int coverId = gameData['cover'];

          String coverUrl = await getCoverUrl(coverId);
          print(coverUrl);
          coverUrl = coverUrl.replaceAll('t_thumb', 't_1080p');

          newReleaseGames.add(VideoGame.fromJson({
            ...gameData,
            'coverUrl': coverUrl,
          }));
        } else {
          print('No data found for game ID: $gameId');
        }
      } else {
        print('No response for game ID: $gameId');
      }
    }
  }

  Future<String> getCoverUrl(int coverId) async {
    String endpoint = "/covers";
    String queryParameters = "fields url; where id = $coverId;";

    String rawResponse =
        await apiService.postRequest(endpoint, queryParameters);

    if (rawResponse.isNotEmpty) {
      List<dynamic> jsonResponse = jsonDecode(rawResponse);

      if (jsonResponse.isNotEmpty) {
        return 'https:${jsonResponse[0]['url']}'; // Prepend with https:
      }
    }

    return ''; // Return empty string if no URL found
  }
}
