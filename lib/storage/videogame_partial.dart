import 'package:hive/hive.dart';

part 'videogame_partial.g.dart';

@HiveType(typeId: 0)
class Game {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String coverUrl;

  @HiveField(3)
  final int firstReleaseDate;

  @HiveField(4)
  final DateTime releaseDate;

  @HiveField(5)
  final double rating;

  Game({
    required this.id,
    required this.name,
    required this.coverUrl,
    required this.firstReleaseDate,
    required this.releaseDate,
    required this.rating,
  });
}
