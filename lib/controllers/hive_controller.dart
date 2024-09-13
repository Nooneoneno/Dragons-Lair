import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:hive/hive.dart';

class HiveController {
  static Future<void> addGameToLibrary(VideoGamePartial game) async {
    var box = await Hive.openBox('userLibrary');
    await box.put(game.id, game);
  }

  static Future<List<VideoGamePartial>> getGameLibrary() async {
    var box = await Hive.openBox('userLibrary');
    return box.values.cast<VideoGamePartial>().toList();
  }

  static Future<void> removeGameFromLibrary(int gameId) async {
    var box = await Hive.openBox('userLibrary');
    await box.delete(gameId);
  }

  static Future<bool> isGameInLibrary(int gameId) async {
    var box = await Hive.openBox('userLibrary');
    return box.containsKey(gameId);
  }
}
