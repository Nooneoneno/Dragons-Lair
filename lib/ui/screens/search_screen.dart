import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cerca Giochi', style: Theme.of(context).textTheme.headlineMedium),
          // Qui andrà il widget per la ricerca
          SizedBox(height: 20),
          Text('Nuove Uscite', style: Theme.of(context).textTheme.headlineMedium),
          // Qui andrà il widget per le nuove uscite
          SizedBox(height: 20),
          Text('Popolari', style: Theme.of(context).textTheme.headlineMedium),
          // Qui andrà il widget per i giochi popolari
        ],
      ),
    );
  }
}