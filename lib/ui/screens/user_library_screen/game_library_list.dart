import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:DragOnPlay/ui/screens/user_library_screen/list_item.dart';
import 'package:flutter/material.dart';

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
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListItem(
            game: library[index],
            onRemoveGame: onRemoveGame,
          ),
        );
      },
    );
  }
}
