import 'package:flutter/material.dart';

class GenreRow extends StatelessWidget {
  final List genres;

  const GenreRow({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: genres.map((genre) {
        return Container(
          margin: EdgeInsets.only(right: 8.0),
          padding: EdgeInsets.symmetric(
              horizontal: 12.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            genre.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
    );
  }
}
