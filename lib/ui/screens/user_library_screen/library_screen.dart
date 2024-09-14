import 'package:DragOnPlay/controllers/storage_controller.dart';
import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:DragOnPlay/ui/screens/user_library_screen/game_library_list.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserLibraryScreen extends StatefulWidget {
  @override
  _UserLibraryScreenState createState() => _UserLibraryScreenState();
}

class _UserLibraryScreenState extends State<UserLibraryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<VideoGamePartial> _library = [];
  List<VideoGamePartial> _favourites = [];

  @override
  void initState() {
    super.initState();
    _loadLibrary();
    _loadFavourites();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _removeGame(int id) async {
    await HiveController.removeGameFromLibrary(id);
    _loadLibrary();
  }

  void _removeFavourite(int id) async {
    await HiveController.removeGameFromFavourite(id);
    _loadFavourites();
  }

  void _loadLibrary() async {
    final games = await HiveController.getGameLibrary();
    setState(() {
      _library = games;
    });
  }

  void _loadFavourites() async {
    final favourites = await HiveController.getGameFavourite();
    setState(() {
      _favourites = favourites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: (_library.isEmpty && _favourites.isEmpty)
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
                  TabBar(
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    dividerColor: Colors.transparent,
                    controller: _tabController,
                    tabs: [
                      Tab(icon: Icon(Icons.library_books), text: 'Library'),
                      Tab(icon: Icon(Icons.favorite), text: 'Favourites'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        GameLibraryListView(
                                collection: _library,
                                onRemoveGame: _removeGame,
                                userBox: Hive.box('userLibrary'),
                              ),
                        GameLibraryListView(
                                collection: _favourites,
                                onRemoveGame: _removeFavourite,
                                userBox: Hive.box('userFavourites')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
