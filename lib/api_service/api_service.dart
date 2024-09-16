import 'package:dragon_lair/api_service/api_handler.dart';
import 'package:dragon_lair/controllers/utility.dart';

class ApiService{
  static const String GAME_ENDPOINT = "/games";
  static const String POPULARITY_ENDPOINT = "/popularity_primitives";
  static const String VIDEOGAMEPARTIAL_ATTRIBUTES =
      "fields name, cover.url, first_release_date, aggregated_rating;";
  static const String VIDEOGAME_ATTRIBUTES =
      "fields *, cover.url, genres.name, platforms.name, themes.name, language_supports.language.name, language_supports.language_support_type.name;";

  static Future<dynamic> fetchGamePartial(
      {String? sort, String? query, String? limit, String? offset}) async {
    String queryParameters =
        "$VIDEOGAMEPARTIAL_ATTRIBUTES${sort ?? ''}${query ?? ''}${limit ?? ''}${offset ?? ''}";

    return await ApiHandler.postRequest(GAME_ENDPOINT, queryParameters);
  }

  static Future<dynamic> fetchGame(
      {String? sort, String? query, String? limit}) async {
    String queryParameters =
        "$VIDEOGAME_ATTRIBUTES${sort ?? ''}${query ?? ''}${limit ?? ''}";

    return await ApiHandler.postRequest(GAME_ENDPOINT, queryParameters);
  }

  static Future<List<int>> fetchPopularGameIds(int popularityType, int limit, int offset) async {
    final queryParameters = "fields game_id; sort value desc; where popularity_type=$popularityType; limit $limit; offset $offset;";
    final rawResponse = await ApiHandler.postRequest(POPULARITY_ENDPOINT, queryParameters);
    final List<int> gameIds = [];

    final List<dynamic> jsonResponse = Utility.parseJson(rawResponse);
    jsonResponse.forEach((gameData) {
      gameIds.add(gameData['game_id']);
    });

    return gameIds;
  }
}