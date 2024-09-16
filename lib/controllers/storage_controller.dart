import 'package:dragon_lair/entities/video_game_partial.dart';
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

  static Future<void> addGameToFavourite(VideoGamePartial game) async {
    var box = await Hive.openBox('userFavourites');
    await box.put(game.id, game);
  }

  static Future<List<VideoGamePartial>> getGameFavourite() async {
    var box = await Hive.openBox('userFavourites');
    return box.values.cast<VideoGamePartial>().toList();
  }

  static Future<void> removeGameFromFavourite(int gameId) async {
    var box = await Hive.openBox('userFavourites');
    await box.delete(gameId);
  }

  static Future<bool> isGameInFavourite(int gameId) async {
    var box = await Hive.openBox('userFavourites');
    return box.containsKey(gameId);
  }
}
