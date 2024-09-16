import 'dart:convert';

import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  // ignore: use_key_in_widget_constructors
  const ExpandableText({required this.text, required this.maxLines});

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
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        );

        final tp = TextPainter(
          maxLines: widget.maxLines,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
          text: span,
        );

        tp.layout(maxWidth: constraints.maxWidth);

        _isOverflowing = tp.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(
                  decodedText,
                  maxLines: _isExpanded ? null : widget.maxLines,
                  overflow: _isExpanded
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                )),
            if (!_isExpanded && _isOverflowing)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Center(
                    child: Text(
                      'Read More',
                      style: TextStyle(
                        color: Colors.white,
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
