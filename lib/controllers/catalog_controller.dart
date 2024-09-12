import 'dart:async';
import 'dart:convert';

import 'package:DragOnPlay/api_service/api_service.dart';
import 'package:DragOnPlay/entities/video_game_partial.dart';

class CatalogController {
  final ApiService apiService = ApiService(baseUrl: 'https://api.igdb.com/v4');

  Stream<List<VideoGamePartial>> getCatalog(int categoryId) async* {
    const String endpoint = "/games";
    int offset = 0;
    const int limit = 500;
    List<VideoGamePartial> catalog = [];
    bool hasMoreData = true;

    while (hasMoreData) {
      final String queryParameters =
          "fields name, cover.url, first_release_date; sort name asc; where genres=$categoryId; limit $limit; offset ${offset * limit};";
      final String rawResponse =
          await apiService.postRequest(endpoint, queryParameters);

      final List<dynamic> jsonResponse = jsonDecode(rawResponse);

      if (jsonResponse.isEmpty) {
        hasMoreData = false;
      } else {
        for (var gameData in jsonResponse) {
          final String coverUrl = extractCoverUrl(gameData['cover']);
          final VideoGamePartial videoGame = VideoGamePartial.fromJson({
            ...gameData,
            'coverUrl': coverUrl,
          });

          catalog.add(videoGame);
        }
        yield catalog;
        offset += 1;
      }
    }
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
