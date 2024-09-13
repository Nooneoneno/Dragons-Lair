import 'package:DragOnPlay/controllers/hive_controller.dart';
import 'package:flutter/material.dart';

import '../../entities/video_game_partial.dart';

class UserLibraryScreen extends StatefulWidget {
  @override
  _UserLibraryScreenState createState() => _UserLibraryScreenState();
}

class _UserLibraryScreenState extends State<UserLibraryScreen> {
  List<VideoGamePartial> _library = [];

  @override
  void initState() {
    super.initState();
    _loadLibrary();
  }

  void _loadLibrary() async {
    final games = await HiveController.getGameLibrary();
    setState(() {
      _library = games;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _library.isEmpty
          ? Center(
              child: Text(
              'Your library is empty!',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ))
          : ListView.builder(
              itemCount: _library.length,
              itemBuilder: (context, index) {
                final game = _library[index];
                return ListTile(
                  title: Text(
                    game.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  subtitle: Text(
                    game.releaseDate.toString(),
                    style: TextStyle(color: Colors.white30),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.redAccent,
                    ),
                    onPressed: () async {
                      await HiveController.removeGameFromLibrary(game.id);
                      _loadLibrary();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                '${game.name} removed from your library!')),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
