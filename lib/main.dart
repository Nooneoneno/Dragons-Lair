import 'package:dragon_lair/api_service/api_handler.dart';
import 'package:dragon_lair/ui/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'entities/video_game_partial.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize .env file
  await dotenv.load(fileName: ".env");

  // Initialize API service
  ApiHandler.initialize(baseUrl: 'https://api.igdb.com/v4');

  // Initialize Hive storage
  await Hive.initFlutter();
  Hive.registerAdapter(VideoGamePartialAdapter());
  await Hive.openBox('userLibrary');
  await Hive.openBox('userFavourites');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyLibrary',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MainScreen(),
    );
  }
}
