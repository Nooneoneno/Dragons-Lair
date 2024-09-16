import 'package:flutter/material.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final BoxFit boxFit;
  final double width;
  final double height;

  NetworkImageWidget(
      {required this.imageUrl,
      required this.boxFit,
      required this.width,
      required this.height});

  @override
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Image.network(
            fit: boxFit,
            width: width,
            height: height,
            imageUrl,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              return Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                    child: Text(
                      "No image available",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    )),
              );
            },
          ),
        ),
      ],
    );
  }
}
