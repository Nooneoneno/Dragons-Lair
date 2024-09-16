import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final BoxFit boxFit;
  final double width;
  final double height;

  const NetworkImageWidget(
      {super.key, required this.imageUrl,
        required this.boxFit,
        required this.width,
        required this.height});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == "loading") {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: width,
          height: height,
          color: Colors.white,
        ),
      );
    }

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
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: width,
                    height: height,
                    color: Colors.white,
                  ),
                ),
              );
            },
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              return Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: const Center(
                  child: Text(
                    "No image available",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
