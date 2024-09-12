import 'dart:convert';

import 'package:DragOnPlay/api_service/api_service.dart';
import 'package:DragOnPlay/entities/video_game_partial.dart';

class CategoryController {
  final ApiService apiService = ApiService(baseUrl: 'https://api.igdb.com/v4');

  Future<List<VideoGamePartial>> getMostRated(int categoryId) async {
    const String endpoint = "/games";
    final String queryParameters =
        "fields name, cover.url, first_release_date; sort rating_count desc; where genres=$categoryId; limit 500;";
    final String rawResponse =
    await apiService.postRequest(endpoint, queryParameters);

    List<VideoGamePartial> mostRatedGames = [];

    final List<dynamic> jsonResponse = jsonDecode(rawResponse);
    jsonResponse.forEach((gameData) {
      final String coverUrl = extractCoverUrl(gameData['cover']);
      final VideoGamePartial videoGame = VideoGamePartial.fromJson({
        ...gameData,
        'coverUrl': coverUrl,
      });

      mostRatedGames.add(videoGame);
    });

    return mostRatedGames;
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