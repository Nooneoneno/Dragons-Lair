import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:flutter/material.dart';
import 'package:DragOnPlay/controllers/hive_controller.dart';

class GameLibraryListView extends StatelessWidget {
  final List<VideoGamePartial> library;
  final Function onRemoveGame;

  const GameLibraryListView({
    super.key,
    required this.library,
    required this.onRemoveGame,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: library.length,
      itemBuilder: (context, index) {
        final game = library[index];
        return ListTile(
          title: Text(
            game.name,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
              onRemoveGame();
            },
          ),
        );
      },
    );
  }
}
