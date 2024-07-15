import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:progetto_esame/ui/screens/explore_screen/category_grid.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

List<String> videogames = [
  'Anno 1452',
  'Minecraft',
  'Stronghold Crusader',
  'The Binding of Isaac',
  '???',
];

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<String> _getSuggestions(String query) {
    return videogames
        .where((game) => game.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void _onSelected(String suggestion) {
    setState(() {
      _searchController.text = suggestion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            TypeAheadField<String>(
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
            SizedBox(height: 15),
            Text(
              'Categorie',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            CategoryGrid(),
          ],
        ));
  }
}
