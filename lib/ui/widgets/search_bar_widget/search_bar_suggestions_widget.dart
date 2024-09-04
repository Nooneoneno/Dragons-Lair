import 'package:flutter/material.dart';
import 'package:progetto_esame/entities/video_game_partial.dart';

class SearchSuggestionsList extends StatelessWidget {
  final List<VideoGamePartial> suggestions;
  final ValueChanged<int> onSuggestionTap;

  const SearchSuggestionsList({
    Key? key,
    required this.suggestions,
    required this.onSuggestionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.transparent,
      height: screenHeight * 0.7,
      child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            leading: suggestion.coverUrl != null
                ? Image.network(
              suggestion.coverUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
                : SizedBox.shrink(),
            title: Text(
              suggestion.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.045,
              ),
            ),
            onTap: () {
              onSuggestionTap(suggestion.id);
            },
          );
        },
      ),
    );
  }
}
