import 'dart:convert';

import 'package:DragOnPlay/api_service/api_service.dart';
import 'package:DragOnPlay/entities/video_game_partial.dart';

class NewReleaseController {
  final ApiService apiService = ApiService(baseUrl: 'https://api.igdb.com/v4');

  Future<List<VideoGamePartial>> fetchNewRelease() async {
    final int nowTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final int lastWeekTimestamp = getLastWeekTimestamp(nowTimestamp);

    const String endpoint = "/games";
    final String queryParameters =
        "fields name, cover.url, first_release_date; sort hypes desc; where first_release_date > $lastWeekTimestamp & first_release_date < $nowTimestamp; limit 25;";
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

  int getLastWeekTimestamp(int nowTimestamp) {
    final DateTime now =
        DateTime.fromMillisecondsSinceEpoch(nowTimestamp * 1000);
    final DateTime twoWeeksAgo = now.subtract(Duration(days: 14));
    final DateTime midnightTwoWeeksAgo =
        DateTime(twoWeeksAgo.year, twoWeeksAgo.month, twoWeeksAgo.day);

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
