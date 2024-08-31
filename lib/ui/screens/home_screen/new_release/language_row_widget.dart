import 'package:flutter/material.dart';
import 'package:progetto_esame/entities/language_support.dart';

class SupportedLanguages extends StatelessWidget {
  final List<LanguageSupport> languages;

  const SupportedLanguages({super.key, required this.languages});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<String>> groupedLanguages = {};

    for (var language in languages) {
      if (!groupedLanguages.containsKey(language.supportTypeName)) {
        groupedLanguages[language.supportTypeName] = [];
      }
      groupedLanguages[language.supportTypeName]!.add(language.languageName);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          'Supported Languages',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        for (var entry in groupedLanguages.entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.key,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: entry.value.map((language) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        language,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
