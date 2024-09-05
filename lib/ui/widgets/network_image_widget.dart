import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final BoxFit boxFit;
  final double width;
  final double height;

  NetworkImageWidget({required this.imageUrl, required this.boxFit, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: boxFit,
      width: width,
      height: height,
      imageUrl: imageUrl,
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Image.asset(
        'assets/placeholder.jpg',
      )
    );
  }
}
