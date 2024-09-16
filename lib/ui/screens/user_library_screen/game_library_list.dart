import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:DragOnPlay/ui/screens/user_library_screen/list_item.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GameLibraryListView extends StatelessWidget {
  final Box userBox;
  final Function(int) onRemoveGame;

  const GameLibraryListView({
    super.key,
    required this.onRemoveGame,
    required this.userBox,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: userBox.listenable(),
        builder: (context, Box box, _) {
          final List<VideoGamePartial> libraryGames =
              box.values.toList().cast<VideoGamePartial>();
          if (libraryGames.isEmpty) {
            return Center(
              child: Text(
                'No games in this tab! :(',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: libraryGames.length,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListItem(
                  game: libraryGames[index],
                  onRemoveGame: onRemoveGame,
                ),
              );
            },
          );
        });
  }
}
