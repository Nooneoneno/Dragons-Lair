import 'package:DragOnPlay/ui/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
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
