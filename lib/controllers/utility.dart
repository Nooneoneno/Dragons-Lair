import 'dart:convert';

import 'package:DragOnPlay/entities/video_game_partial.dart';

class Utility{
  static dynamic parseJson(String rawResponse) => jsonDecode(rawResponse);

  static String extractCoverUrl(dynamic cover) {
    return (cover != null && cover['url'] != null) ? "https:${cover['url']}".replaceAll('t_thumb', 't_1080p') : '';
  }

  static List<VideoGamePartial> mapToVideoGamePartialList(String rawResponse) {
    final jsonResponse = parseJson(rawResponse);
    return mapJsonToVideoGamePartials(jsonResponse);
  }

  static List<VideoGamePartial> mapToUniqueVideoGamePartialList(String rawResponse) {
    final jsonResponse = parseJson(rawResponse);
    final uniqueReleasesMap = {
      for (var game in jsonResponse)
        game['id']: VideoGamePartial.fromJson(
            {...game, 'coverUrl': extractCoverUrl(game['cover'])})
    };
    return uniqueReleasesMap.values.toList();
  }

  static List<VideoGamePartial> mapJsonToVideoGamePartials(
      List<dynamic> jsonResponse) {
    return jsonResponse.map<VideoGamePartial>((gameData) {
      return VideoGamePartial.fromJson({
        ...gameData,
        'coverUrl': extractCoverUrl(gameData['cover']),
      });
    }).toList();
  }
}