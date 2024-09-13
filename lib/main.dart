import 'package:DragOnPlay/ui/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'entities/video_game_partial.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize .env file
  await dotenv.load(fileName: ".env");

  // Initialize Hive storage
  await Hive.initFlutter();
  Hive.registerAdapter(VideoGamePartialAdapter());
  await Hive.openBox('userLibrary');
  await Hive.openBox('userFavourites');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyLibrary',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MainScreen(),
    );
  }
}
