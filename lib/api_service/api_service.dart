import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<String> postRequest(String endpoint, String data) async {
    final url = Uri.parse('$baseUrl$endpoint');

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
