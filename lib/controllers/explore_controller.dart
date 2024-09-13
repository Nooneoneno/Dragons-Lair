import 'dart:convert';

import 'package:DragOnPlay/api_service/api_service.dart';
import 'package:DragOnPlay/entities/category.dart';

class CategoriesController {
  final ApiService apiService = ApiService(baseUrl: 'https://api.igdb.com/v4');

  Future<List<Category>> fetchCategoriesWithoutImages() async {
    const String endpoint = "/genres";
    final String queryParameters = "fields id, name; limit 500;";
    final String rawResponse =
        await apiService.postRequest(endpoint, queryParameters);

    final dynamic jsonResponse = jsonDecode(rawResponse);
    return jsonResponse.map<Category>((categoryData) {
      return Category.fromJson({...categoryData, 'imageUrl': '', 'categoryType': CategoryType.genre});
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
