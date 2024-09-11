import 'dart:convert';

import 'package:DragOnPlay/api_service/api_service.dart';
import 'package:DragOnPlay/entities/video_game_partial.dart';

class CategoryController {
  final ApiService apiService = ApiService(baseUrl: 'https://api.igdb.com/v4');

  Future<List<VideoGamePartial>> getNewReleasesForCategory(int categoryId) async {
    final int nowTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final int lastWeekTimestamp = getLastWeekTimestamp(nowTimestamp);

    const String endpoint = "/games";
    final String queryParameters =
        "fields name, cover.url, first_release_date; sort hypes desc; where first_release_date > $lastWeekTimestamp & first_release_date < $nowTimestamp & genres=$categoryId; limit 5;";
    final String rawResponse =
    await apiService.postRequest(endpoint, queryParameters);

    final Map<int, VideoGamePartial> uniqueReleasesMap = {};

    final List<dynamic> jsonResponse = jsonDecode(rawResponse);
    jsonResponse.forEach((gameData) {
      final String coverUrl = extractCoverUrl(gameData['cover']);
      final VideoGamePartial videoGame = VideoGamePartial.fromJson({
        ...gameData,
        'coverUrl': coverUrl,
      });

      uniqueReleasesMap[videoGame.id] = videoGame;
    });

    final List<VideoGamePartial> uniqueReleases = uniqueReleasesMap.values.toList();
    uniqueReleases
        .sort((a, b) => b.firstReleaseDate.compareTo(a.firstReleaseDate));
    return uniqueReleases;
  }

  Future<List<VideoGamePartial>> getMostRated(int categoryId) async {
    const String endpoint = "/games";
    final String queryParameters =
        "fields name, cover.url, first_release_date; sort rating_count desc; where genres=$categoryId; limit 3;";
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

  int getLastWeekTimestamp(int nowTimestamp) {
    final DateTime now =
    DateTime.fromMillisecondsSinceEpoch(nowTimestamp * 1000);
    final DateTime monthAgo = now.subtract(Duration(days: 30));
    final DateTime midnightTwoWeeksAgo =
    DateTime(monthAgo.year, monthAgo.month, monthAgo.day);

    return midnightTwoWeeksAgo.millisecondsSinceEpoch ~/ 1000;
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