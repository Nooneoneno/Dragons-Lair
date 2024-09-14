import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  static ApiHandler? _instance;
  String baseUrl;

  ApiHandler._internal({required this.baseUrl});


  static void initialize({required String baseUrl}) {
    _instance ??= ApiHandler._internal(baseUrl: baseUrl);
  }

  static ApiHandler get instance {
    if (_instance == null) {
      throw Exception('ApiService is not initialized. Call initialize first.');
    }
    return _instance!;
  }

  static Future<String> postRequest(String endpoint, String data) async {
    final url = Uri.parse('${instance.baseUrl}$endpoint');

    final response = await http.post(
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
      print('Failed to post data. Status code: ${response.statusCode}');
      return "ERROR";
    }
  }
}
