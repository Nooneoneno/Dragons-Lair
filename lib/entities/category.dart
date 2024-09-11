enum CategoryType { category, theme }

class Category {
  final int id;
  final String name;
  late String? imageUrl;
  final CategoryType categoryType;

  Category(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.categoryType});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'],
        name: json['name'],
        imageUrl: json['imageUrl'],
        categoryType: json['categoryType']);
  }
}
