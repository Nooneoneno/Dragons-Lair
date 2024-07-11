import 'package:flutter/material.dart';

class ExploreGridCell extends StatelessWidget {
  final String categoryName;
  final String categoryImage;

  const ExploreGridCell(
      {super.key, required this.categoryName, required this.categoryImage});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          // Immagine di sfondo
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.asset(
              categoryImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Sovrapposizione con testo e sfondo opaco
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(6.0),
              color: Colors.black.withOpacity(0.6),
              child: Text(
                categoryName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
