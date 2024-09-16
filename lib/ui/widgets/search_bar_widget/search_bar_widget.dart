import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function() onTap;

  SearchBarWidget({
    required this.controller,
    required this.onChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: Colors.white,
          fontSize: screenWidth * 0.045,
        ),
        decoration: InputDecoration(
          hintText: 'Search games...',
          hintStyle: TextStyle(color: Colors.white54),
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.white54),
        ),
        onChanged: onChanged,
        onTap: onTap,
      ),
    );
  }
}
