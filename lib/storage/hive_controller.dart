import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:hive/hive.dart';

class HiveHelper {
  static Future<void> addGameToLibrary(VideoGamePartial game) async {
    var box = await Hive.openBox('gameLibrary');
    await box.put(game.id, game);
  }

  static Future<List<VideoGamePartial>> getGameLibrary() async {
    var box = await Hive.openBox('gameLibrary');
    return box.values.cast<VideoGamePartial>().toList();
  }

  static Future<void> removeGameFromLibrary(String gameId) async {
    var box = await Hive.openBox('gameLibrary');
    await box.delete(gameId);
  }

  static Future<bool> isGameInLibrary(String gameId) async {
    var box = await Hive.openBox('gameLibrary');
    return box.containsKey(gameId);
  }
}
