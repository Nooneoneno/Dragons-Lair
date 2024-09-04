import 'package:flutter/material.dart';
import 'package:progetto_esame/controllers/search_controller.dart';
import 'package:progetto_esame/ui/widgets/search_bar_widget/search_bar_widget.dart';

class FullScreenSearch extends StatefulWidget {
  @override
  _FullScreenSearchState createState() => _FullScreenSearchState();
}

class _FullScreenSearchState extends State<FullScreenSearch> {
  TextEditingController _searchController = TextEditingController();
  List<String> suggestions = [];
  bool _isSearchActive = false;
  final SearchApiController searchApiController = SearchApiController();

  void _onSearchTapped() {
    setState(() {
      _isSearchActive = true;
    });
  }

  Future<void> _updateSuggestions(String query) async {
    if (query.isEmpty) {
      setState(() {
        suggestions = [];
      });
      return;
    }

    final List<String> results =
        await searchApiController.getSearchResults(query);

    setState(() {
      suggestions = results;
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
                      SearchBarWidget(
                        controller: _searchController,
                        onChanged: _updateSuggestions,
                        onTap: _onSearchTapped,
                      ),
                      if (suggestions.isNotEmpty)
                        Container(
                          color: Colors.transparent,
                          height: screenHeight * 0.4,
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
