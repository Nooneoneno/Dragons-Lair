import 'dart:convert';

import 'package:progetto_esame/api_service/api_service.dart';

class SearchApiController {
  final ApiService apiService = ApiService(baseUrl: 'https://api.igdb.com/v4');

  Future<List<String>> getSearchResults(String query) async {
    if (query.length >= 2) {
      const String endpoint = "/games";
      final String queryParameters = 'fields name; where name ~ "$query"*; limit 5;';
      final String rawResponse =
          await apiService.postRequest(endpoint, queryParameters);

      final List<String> searchResults = [];

      final List<dynamic> jsonResponse = jsonDecode(rawResponse);
      jsonResponse.forEach((gameData) {
        searchResults.add(gameData['name']);
      });

      return searchResults;
    }
    return [];
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
