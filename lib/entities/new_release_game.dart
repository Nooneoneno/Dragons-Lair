class NewGameRelease {
  final int id;
  final int category;
  final int createdAt;
  final int date;
  final int game;
  final String human;
  final int month;
  final int platform;
  final int region;
  final int updatedAt;
  final int year;
  final String checksum;
  final int status;

  NewGameRelease({
    required this.id,
    required this.category,
    required this.createdAt,
    required this.date,
    required this.game,
    required this.human,
    required this.month,
    required this.platform,
    required this.region,
    required this.updatedAt,
    required this.year,
    required this.checksum,
    required this.status,
  });

  factory NewGameRelease.fromJson(Map<String, dynamic> json) {
    return NewGameRelease(
      id: json['id'] ?? 0,
      category: json['category'] ?? 0,
      createdAt: json['created_at'] ?? 0,
      date: json['date'] ?? 0,
      game: json['game'] ?? 0,
      human: json['human'] ?? '',
      month: json['m'] ?? 0,
      platform: json['platform'] ?? 0,
      region: json['region'] ?? 0,
      updatedAt: json['updated_at'] ?? 0,
      year: json['y'] ?? 0,
      checksum: json['checksum'] ?? '',
      status: json['status'] ?? 0,
    );
  }
}
