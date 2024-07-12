import 'package:flutter/material.dart';

class ExploreGridCell extends StatelessWidget {
  final String categoryName;
  final String categoryImage;

  const ExploreGridCell({
    super.key,
    required this.categoryName,
    required this.categoryImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Aggiunge un'ombra standard
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(8.0), // Bordi arrotondati per la Card
      ),
      child: Stack(
        children: [
          // Immagine di sfondo
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            // Bordi arrotondati per l'immagine
            child: Image.asset(
              categoryImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Container(
                width: double.infinity,
                color: Colors.black.withOpacity(0.6),
                padding: const EdgeInsets.all(6.0),
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
          ),
        ],
      ),
    );
  }
}
