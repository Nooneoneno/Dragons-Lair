import 'dart:convert';

import 'package:progetto_esame/api_service/api_service.dart';
import 'package:progetto_esame/entities/video_game.dart';

class NewReleaseController {
  final ApiService apiService = ApiService(baseUrl: 'https://api.igdb.com/v4');
  List<VideoGame> newReleaseGames = [];

  Future<List<VideoGame>> fetchNewRelease() async {
    if (newReleaseGames.isNotEmpty) {
      return newReleaseGames;
    } else {
      newReleaseGames = await getNewReleases();
      return newReleaseGames;
    }
  }

  Future<List<VideoGame>> getNewReleases() async {
    final int nowTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final int lastWeekTimestamp = getLastWeekTimestamp(nowTimestamp);

    const String endpoint = "/release_dates";
    final String queryParameters =
        "fields game.*, game.cover.url; sort game.hypes desc; where date > $lastWeekTimestamp & date < $nowTimestamp; limit 50;";
    final String rawResponse =
        await apiService.postRequest(endpoint, queryParameters);

    final Map<int, VideoGame> uniqueReleasesMap = {};

    final List<dynamic> jsonResponse = jsonDecode(rawResponse);
    jsonResponse.forEach((gameData) {
      final String coverUrl = extractCoverUrl(gameData['game']['cover']);
      final VideoGame videoGame = VideoGame.fromJson({
        ...gameData['game'],
        'coverUrl': coverUrl,
      });

      uniqueReleasesMap[videoGame.id] = videoGame;
    });

    final List<VideoGame> uniqueReleases = uniqueReleasesMap.values.toList();
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
