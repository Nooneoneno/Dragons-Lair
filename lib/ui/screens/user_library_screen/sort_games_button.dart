import 'package:flutter/material.dart';

class SortGamesButton extends StatelessWidget {
  final Function(String?) applyFilter;
  final String selectedFilter;
  const SortGamesButton({super.key, required this.applyFilter, required this.selectedFilter});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white70),
      ),
      child: DropdownButton<String>(
        value: selectedFilter,
        dropdownColor: Colors.grey[900],
        iconEnabledColor: Colors.white,
        underline: SizedBox(),
        items: [
          DropdownMenuItem(
            child: Text('Alphabetical', style: TextStyle(color: Colors.white)),
            value: 'Alphabetical',
          ),
          DropdownMenuItem(
            child: Text('Category', style: TextStyle(color: Colors.white)),
            value: 'Category',
          ),
          DropdownMenuItem(
            child: Text('Platform', style: TextStyle(color: Colors.white)),
            value: 'Platform',
          ),
        ],
        onChanged: applyFilter,
      ),
    );
  }
}
