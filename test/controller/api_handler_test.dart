import 'package:dragon_lair/api_service/api_handler.dart';
import 'package:dragon_lair/api_service/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'api_handler_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  setUp(() {
    dotenv.testLoad(fileInput: '''
    CLIENT_ID=testClientId
    AUTHORIZATION=testAuthorization
    ''');
  });

  group('ApiHandler', () {
    test('throws an exception if ApiHandler is not initialized', () {
      expect(() => ApiHandler.instance, throwsException);
    });
  });

  group('fetchGames', () {
    test('returns a game if the http call completes successfully', () async {
      final client = MockClient();
      final url = Uri.parse('https://api.igdb.com/v4/games');
      const mockResponse = '''[{
        "id": 0,
        "cover": {
          "id": 0,
          "url": "//images.igdb.com/igdb/image/upload/t_thumb/test.jpg"
        },
        "first_release_date": 0,
        "name": "mock name"
      }]''';

      when(client.post(
        url,
        headers: {
          'Client-ID': 'testClientId',
          'Authorization': 'testAuthorization',
        },
        body: "${ApiService.VIDEOGAMEPARTIAL_ATTRIBUTES}limit 1;",
      )).thenAnswer((_) async => http.Response(mockResponse, 200));

      ApiHandler.dispose();
      ApiHandler.initialize(baseUrl: 'https://api.igdb.com/v4', client: client);

      expect(await ApiHandler.postRequest("/games", "${ApiService.VIDEOGAMEPARTIAL_ATTRIBUTES}limit 1;"), mockResponse);
    });

    test('returns "ERROR" if the http call throws an exception (ex. timeout)', () async {
      final client = MockClient();
      final url = Uri.parse('https://api.igdb.com/v4/games');

      when(client.post(
        url,
        headers: {
          'Client-ID': 'testClientId',
          'Authorization': 'testAuthorization',
        },
        body: "${ApiService.VIDEOGAMEPARTIAL_ATTRIBUTES}limit 1;",
      )).thenThrow(http.ClientException("Network error"));

      ApiHandler.dispose();
      ApiHandler.initialize(baseUrl: 'https://api.igdb.com/v4', client: client);

      expect(await ApiHandler.postRequest("/games", "${ApiService.VIDEOGAMEPARTIAL_ATTRIBUTES}limit 1;"), "ERROR");
    });
  });

  group('fetchGenres', () {
    test('returns a list of genres if the http call completes successfully', () async {
      final client = MockClient();
      final url = Uri.parse('https://api.igdb.com/v4/genres');
      const mockResponse = '''[
        {"id": 0, "name": "Action"},
        {"id": 1, "name": "Adventure"}
      ]''';

      when(client.post(
        url,
        headers: {
          'Client-ID': 'testClientId',
          'Authorization': 'testAuthorization',
        },
        body: "fields name; limit 2;",
      )).thenAnswer((_) async => http.Response(mockResponse, 200));

      ApiHandler.dispose();
      ApiHandler.initialize(baseUrl: 'https://api.igdb.com/v4', client: client);

      expect(await ApiHandler.postRequest("/genres", "fields name; limit 2;"), mockResponse);
    });

    test('returns "ERROR" if the http call for genres fails', () async {
      final client = MockClient();
      final url = Uri.parse('https://api.igdb.com/v4/genres');

      when(client.post(
        url,
        headers: {
          'Client-ID': 'testClientId',
          'Authorization': 'testAuthorization',
        },
        body: "fields name; limit 2;",
      )).thenAnswer((_) async => http.Response("Something went wrong", 500));

      ApiHandler.dispose();
      ApiHandler.initialize(baseUrl: 'https://api.igdb.com/v4', client: client);

      expect(await ApiHandler.postRequest("/genres", "fields name; limit 2;"), "ERROR");
    });
  });
}
