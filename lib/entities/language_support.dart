class LanguageSupport {
  final String languageName;
  final String supportTypeName;

  LanguageSupport({
    required this.languageName,
    required this.supportTypeName,
  });

  factory LanguageSupport.fromJson(Map<String, dynamic> json) {
    return LanguageSupport(
      languageName: json['language']['name'] ?? '',
      supportTypeName: json['language_support_type']['name'] ?? '',
    );
  }
}