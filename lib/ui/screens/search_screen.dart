import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../entities/video_game.dart';

class SearchScreen extends StatefulWidget {
  final void Function(VideoGame) onAddGame;

  const SearchScreen({super.key, required this.onAddGame});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

List<String> videogames = [
  'Anno 1452',
  'Minecraft',
  'Stronghold Crusader',
  'The Binding of Isaac',
  '???',
];

class _SearchScreenState extends State<SearchScreen> {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cerca Giochi',
              style: Theme.of(context).textTheme.headlineMedium),
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
          Text('Nuove Uscite',
              style: Theme.of(context).textTheme.headlineMedium),
          SizedBox(height: 20),
          Text('Popolari', style: Theme.of(context).textTheme.headlineMedium),
        ],
      ),
    );
  }
}