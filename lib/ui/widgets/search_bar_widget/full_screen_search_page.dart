import 'package:GameHub/controllers/search_controller.dart';
import 'package:GameHub/entities/video_game_partial.dart';
import 'package:GameHub/ui/widgets/game_details_widget/game_details_page.dart';
import 'package:GameHub/ui/widgets/search_bar_widget/search_bar_suggestions_widget.dart';
import 'package:GameHub/ui/widgets/search_bar_widget/search_bar_widget.dart';
import 'package:flutter/material.dart';

class FullScreenSearch extends StatefulWidget {
  @override
  _FullScreenSearchState createState() => _FullScreenSearchState();
}

class _FullScreenSearchState extends State<FullScreenSearch> {
  TextEditingController _searchController = TextEditingController();
  List<VideoGamePartial> suggestions = [];
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

    final List<VideoGamePartial> results =
        await searchApiController.getSearchResults(query);

    setState(() {
      suggestions = results;
    });
  }

  void _onSuggestionTap(int gameId) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (BuildContext context, _, __) => GameDetailsPage(gameId: gameId),
      ),
    );
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
                      SizedBox(height: 12),
                      if (suggestions.isNotEmpty)
                        SearchSuggestionsList(
                          suggestions: suggestions,
                          onSuggestionTap: _onSuggestionTap,
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
