import 'package:dragon_lair/controllers/api_controller.dart';
import 'package:dragon_lair/entities/video_game_partial.dart';
import 'package:dragon_lair/ui/screens/common_screens/retry_page.dart';
import 'package:dragon_lair/ui/screens/explore_screen/explore_screen.dart';
import 'package:dragon_lair/ui/screens/home_screen/home_screen.dart';
import 'package:dragon_lair/ui/screens/user_library_screen/library_screen.dart';
import 'package:dragon_lair/ui/widgets/search_bar_widget/full_screen_search_page.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ApiController apiController = ApiController();
  List<VideoGamePartial> newReleases = [];
  List<VideoGamePartial> popularGames = [];
  bool _isFetching = false;
  bool _fetchFailed = false;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    if (newReleases.isEmpty || popularGames.isEmpty) {
      _fetchGames();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getCurrentScreen() {
    if (_isFetching) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }

    if (_fetchFailed) {
      return RetryPage(retryFetching: _fetchGames);
    }

    switch (_selectedIndex) {
      case 0:
        return ExploreScreen();
      case 1:
        return HomeScreen(
          fetchGames: _fetchGames,
          newReleases: newReleases,
          popularGames: popularGames,
        );
      case 2:
        return const UserLibraryScreen();
      default:
        return HomeScreen(
          fetchGames: _fetchGames,
          newReleases: newReleases,
          popularGames: popularGames,
        );
    }
  }

  void _openSearch() {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => const FullScreenSearch(),
      ),
    );
  }

  Future<void> _fetchGames() async {
    setState(() {
      _isFetching = true;
      _fetchFailed = false;
    });

    try {
      var newGames = await apiController.fetchNewRelease();
      var popGames = await apiController.fetchPopularGames(50, 0);
      setState(() {
        newReleases = newGames;
        popularGames = popGames;
        _isFetching = false;
      });
    } catch (e) {
      // In caso di errore di fetching
      setState(() {
        _isFetching = false;
        _fetchFailed = true; // Imposta lo stato di errore
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black87, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: const Text(
                '''Dragon's Lair''',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.white),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  color: Colors.white,
                  onPressed: _openSearch,
                ),
              ],
            ),
            body: _getCurrentScreen(),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.library_books),
                  label: 'Library',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white54,
              backgroundColor: Colors.transparent,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
            ),
          ),
        ],
      ),
    );
  }
}
