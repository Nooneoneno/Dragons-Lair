import 'package:hive/hive.dart';

part 'video_game_partial.g.dart';

@HiveType(typeId: 0)
class VideoGamePartial {
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

  VideoGamePartial({
    required this.id,
    required this.name,
    required this.coverUrl,
    required this.firstReleaseDate,
    required this.releaseDate,
    required this.rating,
  });

  factory VideoGamePartial.fromJson(Map<String, dynamic> json) {
    int releaseDateTimestamp = json['first_release_date'] ?? 0;
    DateTime humanReleaseDate =
        DateTime.fromMillisecondsSinceEpoch(releaseDateTimestamp * 1000);

    return VideoGamePartial(
      id: json['id'] ?? 0,
      name: json['name'] ?? 0,
      coverUrl: json['coverUrl'] ?? '',
      firstReleaseDate: releaseDateTimestamp,
      releaseDate: humanReleaseDate,
      rating: json['aggregated_rating'] != null
          ? double.parse(
              (json['aggregated_rating'] as double).toStringAsFixed(1))
          : 0.0,
    );
  }
}
