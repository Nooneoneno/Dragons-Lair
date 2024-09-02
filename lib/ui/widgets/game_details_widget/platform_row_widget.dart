import 'package:flutter/material.dart';

class PlatformRow extends StatelessWidget {
  final List platforms;

  const PlatformRow({super.key, required this.platforms});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: platforms.map((platform) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            platform.toString(),
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
