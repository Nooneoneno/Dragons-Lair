import 'dart:convert'; // Per utf8.decode

import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  ExpandableText({required this.text});

  @override
  _GameDescriptionState createState() => _GameDescriptionState();
}

class _GameDescriptionState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final String storyline = utf8.decode(widget.text.runes.toList());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          storyline,
          maxLines: _isExpanded ? null : 2,
          overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
        if (storyline.split('\n').length > 2)
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Center(
                child: Text(
                  _isExpanded ? 'Read Less' : 'Read More',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
