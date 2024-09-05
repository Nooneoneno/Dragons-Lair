import 'package:DragOnPlay/entities/language_support.dart';

class VideoGame {
  final int id;
  final List<int> ageRatings;
  final int category;
  final String coverUrl;
  final List<int> dlcs;
  final int firstReleaseDate;
  final DateTime humanFirstReleaseDate;
  final List<String> genres;
  final List<LanguageSupport> languageSupports;
  final String name;
  final int parentGame;
  final List<String> platforms;
  final List<int> remakes;
  final List<int> remasters;
  final int status;
  final String storyline;
  final String summary;
  final List<String> themes;
  final int lastUpdated;

  VideoGame({
    required this.id,
    required this.ageRatings,
    required this.category,
    required this.coverUrl,
    required this.dlcs,
    required this.firstReleaseDate,
    required this.humanFirstReleaseDate,
    required this.genres,
    required this.languageSupports,
    required this.name,
    required this.parentGame,
    required this.platforms,
    required this.remakes,
    required this.remasters,
    required this.status,
    required this.storyline,
    required this.summary,
    required this.themes,
    required this.lastUpdated,
  });

  factory VideoGame.fromJson(Map<String, dynamic> json) {
    int releaseDateTimestamp = json['first_release_date'] ?? 0;
    DateTime humanReleaseDate =
        DateTime.fromMillisecondsSinceEpoch(releaseDateTimestamp * 1000);
    List<int> dlcs = List<int>.from(json['dlcs'] ?? []);
    dlcs.addAll(List<int>.from(json['expansions'] ?? []));

    return VideoGame(
      id: json['id'] ?? 0,
      ageRatings: List<int>.from(json['age_ratings'] ?? []),
      category: json['category'] ?? 0,
      coverUrl: json['coverUrl'] ?? '',
      dlcs: dlcs,
      firstReleaseDate: json['first_release_date'] ?? 0,
      humanFirstReleaseDate: humanReleaseDate,
      genres: json['genres'] != null
          ? (json['genres'] as List)
              .map((genre) => genre['name'] as String)
              .toList()
          : [],
      languageSupports: (json['language_supports'] as List<dynamic>?)
              ?.map((langSupport) => LanguageSupport.fromJson(langSupport))
              .toList() ??
          [],
      name: json['name'] ?? '',
      parentGame: json['parent_game'] ?? 0,
      platforms: json['platforms'] != null
          ? (json['platforms'] as List)
              .map((platform) => platform['name'] as String)
              .toList()
          : [],
      remakes: List<int>.from(json['remakes'] ?? []),
      remasters: List<int>.from(json['remasters'] ?? []),
      status: json['status'] ?? 0,
      storyline: json['storyline'] ?? '',
      summary: json['summary'] ?? '',
      themes: json['themes'] != null
          ? (json['themes'] as List)
              .map((theme) => theme['name'] as String)
              .toList()
          : [],
      lastUpdated: json['updated_at'] ?? 0,
    );
  }
}
