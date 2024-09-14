import 'dart:convert';

import 'package:DragOnPlay/api_service/api_service.dart';
import 'package:DragOnPlay/entities/category.dart';
import 'package:DragOnPlay/entities/video_game.dart';
import 'package:DragOnPlay/entities/video_game_partial.dart';

class ApiController {
  final ApiService apiService = ApiService(baseUrl: 'https://api.igdb.com/v4');

  Future<VideoGame> getGame(int id) async {
    const String endpoint = "/games";
    final String queryParameters =
        "fields *, cover.url, genres.name, platforms.name, themes.name, language_supports.language.name, language_supports.language_support_type.name; where id=$id;";
    final String rawResponse =
        await apiService.postRequest(endpoint, queryParameters);

    final dynamic jsonResponse = jsonDecode(rawResponse);
    if (jsonResponse.isEmpty) {
      throw Exception("No game found with the given ID.");
    }

    final dynamic gameData = jsonResponse[0];
    final String coverUrl = extractCoverUrl(gameData['cover']);
    final VideoGame videoGame = VideoGame.fromJson({
      ...gameData,
      'coverUrl': coverUrl,
    });

    return videoGame;
  }

  Future<VideoGamePartial> getPartialGame(int id) async {
    const String endpoint = "/games";
    final String queryParameters =
        "fields name, cover.url, first_release_date; where id=$id;";
    final String rawResponse =
        await apiService.postRequest(endpoint, queryParameters);

    final dynamic jsonResponse = jsonDecode(rawResponse);
    if (jsonResponse.isEmpty) {
      throw Exception("No game found with the given ID.");
    }

    final dynamic gameData = jsonResponse[0];
    final String coverUrl = extractCoverUrl(gameData['cover']);
    final VideoGamePartial videoGame = VideoGamePartial.fromJson({
      ...gameData,
      'coverUrl': coverUrl,
    });

    return videoGame;
  }

  Future<List<VideoGamePartial>> getSearchResults(String query) async {
    if (query.length >= 2) {
      const String endpoint = "/games";
      final String queryParameters =
          'fields name, cover.url, first_release_date; sort rating desc; where name ~ "$query"* & category=(0,1,2,3,4,8,9,11); limit 10;';
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

  Future<List<VideoGamePartial>> getMostRated(int categoryId) async {
    const String endpoint = "/games";
    final String queryParameters =
        "fields name, cover.url, first_release_date, aggregated_rating; sort aggregated_rating desc; where genres=$categoryId & aggregated_rating >= 75; limit 500;";
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

    final List<VideoGamePartial> uniqueReleases =
        uniqueReleasesMap.values.toList();
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

  Future<List<Category>> fetchCategoriesWithoutImages() async {
    const String endpoint = "/genres";
    final String queryParameters = "fields id, name; limit 500;";
    final String rawResponse =
        await apiService.postRequest(endpoint, queryParameters);

    final dynamic jsonResponse = jsonDecode(rawResponse);
    return jsonResponse.map<Category>((categoryData) {
      return Category.fromJson({
        ...categoryData,
        'imageUrl': '',
        'categoryType': CategoryType.genre
      });
    }).toList();
  }

  Stream<Category> fetchCategoryImages(List<Category> categories) async* {
    const int batchSize = 4;

    for (int i = 0; i < categories.length; i += batchSize) {
      final batch = categories.sublist(
          i,
          i + batchSize > categories.length
              ? categories.length
              : i + batchSize);

      List<Future<Category>> futureCategories = batch.map((category) async {
        String imageUrl = "";
        if (category.categoryType == CategoryType.genre) {
          imageUrl = await getCover("genres=${category.id}");
        } else {
          imageUrl = await getCover("themes=${category.id}");
        }
        category.imageUrl = imageUrl;
        return category;
      }).toList();

      for (var futureCategory in await Future.wait(futureCategories)) {
        yield futureCategory;
      }
    }
  }

  Future<String> getCover(String query) async {
    final String endpoint = "/games";
    final String queryParameters =
        "fields name, cover.url; sort rating desc; where $query; limit 1;";
    final String rawResponse =
        await apiService.postRequest(endpoint, queryParameters);

    final dynamic jsonResponse = jsonDecode(rawResponse);
    if (jsonResponse.isEmpty) {
      return '';
    }

    final dynamic gameData = jsonResponse[0];
    return (gameData['cover'] != null && gameData['cover'].isNotEmpty)
        ? extractCoverUrl(gameData['cover'])
        : '';
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
