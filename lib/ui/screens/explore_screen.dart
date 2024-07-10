import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Impostazioni',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}