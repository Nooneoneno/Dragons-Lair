class VideoGamePartial {
  final int id;
  final String name;
  final String coverUrl;
  final int firstReleaseDate;
  final DateTime releaseDate;

  VideoGamePartial({
    required this.id,
    required this.name,
    required this.coverUrl,
    required this.firstReleaseDate,
    required this.releaseDate,
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
        releaseDate: humanReleaseDate);
  }
}
