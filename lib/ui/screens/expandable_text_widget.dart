import 'dart:convert';

import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  ExpandableText({required this.text});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;
  bool _isOverflowing = false;
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        String decodedText = utf8.decode(widget.text.runes.toList());

        final span = TextSpan(
          text: decodedText,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        );

        final tp = TextPainter(
          maxLines: 2,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
          text: span,
        );

        tp.layout(maxWidth: constraints.maxWidth);

        _isOverflowing = tp.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              decodedText,
              maxLines: _isExpanded ? null : 2,
              overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            if (_isOverflowing)
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
      },
    );
  }
}
