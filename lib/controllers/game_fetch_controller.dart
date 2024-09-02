import 'dart:convert';

import 'package:progetto_esame/api_service/api_service.dart';
import 'package:progetto_esame/entities/video_game.dart';
import 'package:progetto_esame/entities/video_game_partial.dart';

class GameFetchController {
  final ApiService apiService = ApiService(baseUrl: 'https://api.igdb.com/v4');

  Future<VideoGame> getGame(int id) async {
    const String endpoint = "/games";
    final String queryParameters =
        "fields *, cover.url, genres.name, platforms.name, themes.name, language_supports.language.name, language_supports.language_support_type.name; where id=$id;";
    final String rawResponse = await apiService.postRequest(endpoint, queryParameters);

    final dynamic jsonResponse = jsonDecode(rawResponse);
    if (jsonResponse.isEmpty) {
      throw Exception("No game found with the given ID.");
    }

    final dynamic gameData = jsonResponse[0];
    final String coverUrl = extractCoverUrl(gameData['cover']);
    final VideoGame videoGame = VideoGame.fromJson({
      ...gameData,
      'coverUrl': coverUrl,
    });

    return videoGame;
  }

  Future<VideoGamePartial> getPartialGame(int id) async {
    const String endpoint = "/games";
    final String queryParameters =
        "fields name, cover.url, first_release_date; where id=$id;";
    final String rawResponse = await apiService.postRequest(endpoint, queryParameters);

    final dynamic jsonResponse = jsonDecode(rawResponse);
    if (jsonResponse.isEmpty) {
      throw Exception("No game found with the given ID.");
    }

    final dynamic gameData = jsonResponse[0];
    final String coverUrl = extractCoverUrl(gameData['cover']);
    final VideoGamePartial videoGame = VideoGamePartial.fromJson({
      ...gameData,
      'coverUrl': coverUrl,
    });

    return videoGame;
  }

  String extractCoverUrl(dynamic cover) {
    if (cover != null && cover['url'] != null) {
      String coverUrl =
      cover['url'].toString().replaceAll('t_thumb', 't_1080p');
      return "https:$coverUrl";
    }
    return '';
  }
}
