import 'package:GameHub/api_service/api_service.dart';
import 'package:flutter/material.dart';

class TestAPI extends StatelessWidget {
  TestAPI({super.key});

  final ApiService apiService = ApiService(baseUrl: 'https://api.igdb.com/v4');

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
        onPressed: () async {
      await apiService.postRequest('/themes', 'fields *; limit 500;');
    },
    child: Text('Send POST Request'),
    ));
  }
}
