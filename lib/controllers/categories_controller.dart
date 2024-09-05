import 'dart:convert';

import 'package:DragOnPlay/api_service/api_service.dart';
import 'package:DragOnPlay/entities/category.dart';

class CategoriesController {
  final ApiService apiService = ApiService(baseUrl: 'https://api.igdb.com/v4');

  Future<List<Category>> fetchCategories() async {
    const String endpoint = "/genres";
    final String queryParameters = "fields name; limit 500;";
    final String rawResponse = await apiService.postRequest(endpoint, queryParameters);

    final dynamic jsonResponse = jsonDecode(rawResponse);

    List<Future<Category>> categoryFutures = jsonResponse.map<Future<Category>>((categoryData) async {
      String imageUrl = await getCategoryCover(categoryData['id']);
      return Category.fromJson({...categoryData, 'imageUrl': imageUrl});
    }).toList();

    List<Category> categories = await Future.wait(categoryFutures);
    categories.sort((a, b) => a.name.compareTo(b.name));
    return categories;
  }

  Future<String> getCategoryCover(int category) async {
    final String endpoint = "/games";
    final String queryParameters =
        "fields name, cover.url; sort rating desc; where genres=$category; limit 1;";
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
      String coverUrl = cover['url'].toString().replaceAll('t_thumb', 't_1080p');
      return "https:$coverUrl";
    }
    return '';
  }
}
