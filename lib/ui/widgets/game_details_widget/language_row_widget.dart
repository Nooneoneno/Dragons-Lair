import 'package:DragOnPlay/entities/language_support.dart';
import 'package:flutter/material.dart';

class SupportedLanguages extends StatefulWidget {
  final List<LanguageSupport> languages;

  const SupportedLanguages({super.key, required this.languages});

  @override
  _SupportedLanguagesState createState() => _SupportedLanguagesState();
}

class _SupportedLanguagesState extends State<SupportedLanguages> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, List<String>> groupedLanguages = {};
    final Set<String> uniqueLanguages = {};

    for (var language in widget.languages) {
      if (!groupedLanguages.containsKey(language.supportTypeName)) {
        groupedLanguages[language.supportTypeName] = [];
      }
      groupedLanguages[language.supportTypeName]!.add(language.languageName);
      uniqueLanguages.add(language.languageName);
    }

    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!_isExpanded)
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: uniqueLanguages.map((language) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.language, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text(
                            language,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              if (_isExpanded)
                ...groupedLanguages.entries.map((entry) {
                  return Column(
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 4.0),
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
                  );
                }).toList(),
            ],
          ),
          SizedBox(height: 4),
          if (!_isExpanded)
            Center(
              child: Text(
                'More Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
        ]),
      ),
    );
  }
}
