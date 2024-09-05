import 'dart:convert';

import 'package:progetto_esame/api_service/api_service.dart';
import 'package:progetto_esame/entities/video_game_partial.dart';

class SearchApiController {
  final ApiService apiService = ApiService(baseUrl: 'https://api.igdb.com/v4');

  Future<List<VideoGamePartial>> getSearchResults(String query) async {
    if (query.length >= 2) {
      const String endpoint = "/games";
      final String queryParameters =
          'fields name, cover.url, first_release_date; where name ~ "$query"* & category=(0,1,2,3,4,8,9,11); limit 5;';
      final String rawResponse =
          await apiService.postRequest(endpoint, queryParameters);

      final List<VideoGamePartial> searchResults = [];

      final List<dynamic> jsonResponse = jsonDecode(rawResponse);
      jsonResponse.forEach((gameData) {
        final String coverUrl = extractCoverUrl(gameData['cover']);
        final VideoGamePartial videoGame = VideoGamePartial.fromJson({
          ...gameData,
          'coverUrl': coverUrl,
        });
        searchResults.add(videoGame);
      });

      return searchResults;
    }
    return [];
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
