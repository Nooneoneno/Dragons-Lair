import 'package:flutter/material.dart';

class FullScreenSearch extends StatefulWidget {
  @override
  _FullScreenSearchState createState() => _FullScreenSearchState();
}

class _FullScreenSearchState extends State<FullScreenSearch> {
  TextEditingController _searchController = TextEditingController();
  List<String> suggestions = [];
  List<String> allItems = [
    'Assassin\'s Creed',
    'Battlefield',
    'Call of Duty',
    'Cyberpunk 2077',
    'Dark Souls',
    'Elden Ring',
    'Far Cry',
    'Fortnite',
    'Genshin Impact',
    'God of War',
  ];

  bool _isSearchActive = false;

  void _updateSuggestions(String query) {
    setState(() {
      suggestions = allItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onSearchTapped() {
    setState(() {
      _isSearchActive = true;
    });
  }

  void _closeSearch() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: _closeSearch,
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.8),
        body: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              top: _isSearchActive ? screenHeight * 0.1 : screenHeight * 0.4,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Column(
                    children: [
                      TextField(
                        controller: _searchController,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.05,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                        ),
                        onChanged: _updateSuggestions,
                        onTap: _onSearchTapped,
                      ),
                      SizedBox(height: 20),
                      if (suggestions.isNotEmpty)
                        Container(
                          color: Colors.transparent,
                          height: screenHeight * 0.3,
                          child: ListView.builder(
                            itemCount: suggestions.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  suggestions[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.045,
                                  ),
                                ),
                                onTap: () {
                                  print(
                                      'Hai selezionato: ${suggestions[index]}');
                                },
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
