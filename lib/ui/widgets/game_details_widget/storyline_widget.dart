import 'package:flutter/material.dart';

import '../../screens/expandable_text_widget.dart';

class StorylineText extends StatelessWidget {
  final String storyline;

  const StorylineText({super.key, required this.storyline});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Story',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          ExpandableText(text: storyline, maxLines: 6,)
        ],
      ),
    );
  }
}


