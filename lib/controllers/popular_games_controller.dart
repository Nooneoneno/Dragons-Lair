import 'dart:convert';

import 'package:DragOnPlay/api_service/api_service.dart';
import 'package:DragOnPlay/entities/video_game_partial.dart';

class PopularGamesController {
  final ApiService apiService = ApiService(baseUrl: 'https://api.igdb.com/v4');

  Future<List<int>> getPopularGameIds(
      int popularityType, int limit, int offset) async {
    const String endpoint = "/popularity_primitives";
    final String queryParameters =
        "fields game_id; sort value desc; where popularity_type=$popularityType; limit $limit; offset $offset;";
    final String rawResponse =
        await apiService.postRequest(endpoint, queryParameters);

    final List<int> gameIds = [];

    final List<dynamic> jsonResponse = jsonDecode(rawResponse);
    jsonResponse.forEach((gameData) {
      gameIds.add(gameData['game_id']);
    });

    return gameIds;
  }

  Future<List<VideoGamePartial>> fetchPopularGames(
      int limit, int offset) async {
    const String endpoint = "/games";
    final List<int> gameIds = await getPopularGameIds(3, limit, offset);

    if (gameIds.isEmpty) {
      return [];
    }

    final String queryParameters =
        'fields name, cover.url, first_release_date; where id = (${gameIds.join(', ')}); limit $limit;';
    final String rawResponse =
        await apiService.postRequest(endpoint, queryParameters);

    final List<dynamic> jsonResponse = jsonDecode(rawResponse);
    final Map<int, VideoGamePartial> uniqueReleasesMap = {};

    for (var gameData in jsonResponse) {
      final String coverUrl = extractCoverUrl(gameData['cover']);
      final VideoGamePartial videoGame = VideoGamePartial.fromJson({
        ...gameData,
        'coverUrl': coverUrl,
      });
      uniqueReleasesMap[videoGame.id] = videoGame;
    }
    final List<VideoGamePartial> uniqueReleases =
        uniqueReleasesMap.values.toList();

    return uniqueReleases;
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
