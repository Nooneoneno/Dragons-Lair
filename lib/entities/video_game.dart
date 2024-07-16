class VideoGame {
  final int id;
  final int category;
  final int cover;
  final List<int> dlcs;
  final List<int> expandedGames;
  final List<int> expansions;
  final int firstReleaseDate;
  final List<int> genres;
  final List<dynamic> involvedCompanies;
  final List<dynamic> languageSupports;
  final List<dynamic> multiplayerModes;
  final String name;
  final List<int> platforms;
  final List<int> releaseDates;
  final List<int> similarGames;
  final List<int> standaloneExpansions;
  final int status;
  final String storyline;
  final String summary;
  final List<int> themes;
  final String versionTitle;

  VideoGame({
    required this.id,
    required this.category,
    required this.cover,
    required this.dlcs,
    required this.expandedGames,
    required this.expansions,
    required this.firstReleaseDate,
    required this.genres,
    required this.involvedCompanies,
    required this.languageSupports,
    required this.multiplayerModes,
    required this.name,
    required this.platforms,
    required this.releaseDates,
    required this.similarGames,
    required this.standaloneExpansions,
    required this.status,
    required this.storyline,
    required this.summary,
    required this.themes,
    required this.versionTitle,
  });

  factory VideoGame.fromJson(Map<String, dynamic> json) {
    return VideoGame(
      id: json['id'] ?? 0,
      category: json['category'] ?? 0,
      cover: json['cover'],
      dlcs: List<int>.from(json['dlcs'] ?? []),
      expandedGames: List<int>.from(json['expanded_games'] ?? []),
      expansions: List<int>.from(json['expansions'] ?? []),
      firstReleaseDate: json['first_release_date'] ?? 0,
      genres: List<int>.from(json['genres'] ?? []),
      involvedCompanies: List<dynamic>.from(json['involved_companies'] ?? []),
      languageSupports: List<dynamic>.from(json['language_supports'] ?? []),
      multiplayerModes: List<dynamic>.from(json['multiplayer_modes'] ?? []),
      name: json['name'] ?? '',
      platforms: List<int>.from(json['platforms'] ?? []),
      releaseDates: List<int>.from(json['release_dates'] ?? []),
      similarGames: List<int>.from(json['similar_games'] ?? []),
      standaloneExpansions: List<int>.from(json['standalone_expansions'] ?? []),
      status: json['status'] ?? 0,
      storyline: json['storyline'] ?? '',
      summary: json['summary'] ?? '',
      themes: List<int>.from(json['themes'] ?? []),
      versionTitle: json['version_title'] ?? '',
    );
  }
}
