import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  static ApiHandler? _instance;
  String baseUrl;
  http.Client client;

  ApiHandler._internal({required this.baseUrl, http.Client? client})
      : client = client ?? http.Client();

  static void initialize({required String baseUrl, http.Client? client}) {
    _instance ??= ApiHandler._internal(baseUrl: baseUrl, client: client);
  }

  static void dispose(){
    _instance = null;
  }

  static ApiHandler get instance {
    if (_instance == null) {
      throw Exception('ApiService is not initialized. Call initialize first.');
    }
    return _instance!;
  }

  static Future<String> postRequest(String endpoint, String data) async {
    final url = Uri.parse('${instance.baseUrl}$endpoint');

    try {
      final response = await instance.client.post(
        url,
        headers: {
          'Client-ID': dotenv.env['CLIENT_ID']!,
          'Authorization': dotenv.env['AUTHORIZATION']!,
        },
        body: data,
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "ERROR";
      }
    } catch (e) {
      return "ERROR";
    }
  }
}
