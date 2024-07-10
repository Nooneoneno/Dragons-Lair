import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:progetto_esame/ui/screens/home_screen/new_release_widget.dart';
import 'package:progetto_esame/ui/screens/home_screen/popular_widget.dart';
import '../../../entities/video_game.dart';

class HomeScreen extends StatefulWidget {
  final void Function(VideoGame) onAddGame;

  const HomeScreen({super.key, required this.onAddGame});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List<String> videogames = [
  'Anno 1452',
  'Minecraft',
  'Stronghold Crusader',
  'The Binding of Isaac',
  '???',
];

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<String> _getSuggestions(String query) {
    return videogames
        .where((game) => game.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void _onSelected(String suggestion) {
    setState(() {
      _searchController.text = suggestion;

      widget.onAddGame(
        VideoGame(
          name: suggestion,
          genre: 'Azione',
          online: 'Co-op',
          publisher: 'Bethesda',
          referenceStore: 'Steam',
          releaseDate: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TypeAheadField<String>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Inserisci il nome del gioco',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
                suggestionsCallback: _getSuggestions,
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                onSuggestionSelected: _onSelected,
              ),
            ),
            SizedBox(height: 20),
            NewReleasesWidget(),
            SizedBox(height: 20),
            PopularWidget(),
          ],
        ),
      ),
    );
  }
}