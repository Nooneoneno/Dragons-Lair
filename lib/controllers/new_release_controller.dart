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
    final DateTime now = DateTime.now();
    final int nowTimestamp = now.millisecondsSinceEpoch ~/ 1000;
    final DateTime lastMonday = DateTime(now.year, now.month, now.day - now.weekday + 1);
    final int lastWeekTimestamp = lastMonday.millisecondsSinceEpoch ~/ 1000;

    const String endpoint = "/release_dates";
    final String queryParameters =
        "fields game.*, game.cover.url; sort game.hypes desc; where date > $lastWeekTimestamp & date < $nowTimestamp & platform = 6; limit 10;";
    final String rawResponse = await apiService.postRequest(endpoint, queryParameters);

    final List<dynamic> jsonResponse = jsonDecode(rawResponse);
    final List<VideoGame> releases = jsonResponse.map((gameData) {
      final String coverUrl = extractCoverUrl(gameData['game']['cover']);
      return VideoGame.fromJson({
        ...gameData['game'],
        'coverUrl': coverUrl,
      });
    }).toList();

    return releases;
  }

  String extractCoverUrl(dynamic cover) {
    if (cover != null && cover['url'] != null) {
      String coverUrl = cover['url'].toString().replaceAll('t_thumb', 't_1080p');
      return "https:$coverUrl";
    }
    return '';
  }
}
