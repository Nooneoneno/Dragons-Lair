import 'package:DragOnPlay/controllers/hive_controller.dart';
import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:DragOnPlay/ui/screens/user_library_screen/game_library_list.dart';
import 'package:DragOnPlay/ui/screens/user_library_screen/sort_games_button.dart';
import 'package:flutter/material.dart';

class UserLibraryScreen extends StatefulWidget {
  @override
  _UserLibraryScreenState createState() => _UserLibraryScreenState();
}

class _UserLibraryScreenState extends State<UserLibraryScreen> {
  List<VideoGamePartial> _library = [];
  String _selectedFilter = 'Alphabetical';

  @override
  void initState() {
    super.initState();
    _loadLibrary();
  }

  void _applyFilter(String? value) {
    setState(() {
      _selectedFilter = value!;
    });
  }

  void _loadLibrary() async {
    final games = await HiveController.getGameLibrary();
    setState(() {
      _library = games;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: _library.isEmpty
            ? Center(
                child: Text(
                'Your library is empty!',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ))
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SortGamesButton(
                          applyFilter: _applyFilter,
                          selectedFilter: _selectedFilter),
                      Expanded(
                          child: GameLibraryListView(
                              library: _library, onRemoveGame: _loadLibrary)),
                    ])));
  }
}
