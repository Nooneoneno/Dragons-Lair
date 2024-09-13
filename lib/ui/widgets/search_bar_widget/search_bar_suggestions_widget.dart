import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:DragOnPlay/ui/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';

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
      constraints: BoxConstraints(
        maxHeight: screenHeight * 0.6,
      ),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        shrinkWrap: true,
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            leading: Container(
              width: 50,
              height: 50,
              child: NetworkImageWidget(
                imageUrl: suggestion.coverUrl,
                boxFit: BoxFit.fill,
                width: 50,
                height: 50,
              ),
            ),
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
