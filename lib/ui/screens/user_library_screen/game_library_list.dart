import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:DragOnPlay/ui/screens/user_library_screen/list_item.dart';
import 'package:flutter/material.dart';

class GameLibraryListView extends StatelessWidget {
  final List<VideoGamePartial> collection;
  final Function(int) onRemoveGame;

  const GameLibraryListView({
    super.key,
    required this.collection,
    required this.onRemoveGame,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: collection.length,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListItem(
            game: collection[index],
            onRemoveGame: onRemoveGame,
          ),
        );
      },
    );
  }
}
