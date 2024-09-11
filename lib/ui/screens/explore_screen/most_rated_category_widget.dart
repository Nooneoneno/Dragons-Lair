import 'package:DragOnPlay/entities/video_game_partial.dart';
import 'package:DragOnPlay/ui/screens/explore_screen/new_release_card_widget.dart';
import 'package:flutter/material.dart';

class MostRatedCategory extends StatelessWidget {
  const MostRatedCategory({super.key});

  @override
  Widget build(BuildContext context) {
    List<VideoGamePartial> mostRated = [
      VideoGamePartial(
          id: 1,
          name: "The Last of Us",
          coverUrl: "https://via.placeholder.com/150",
          firstReleaseDate: 0,
          releaseDate: DateTime(2002)),
      VideoGamePartial(
          id: 1,
          name: "God of War",
          coverUrl: "https://via.placeholder.com/150",
          firstReleaseDate: 0,
          releaseDate: DateTime(2002)),
      VideoGamePartial(
          id: 1,
          name: "Fifa 2024",
          coverUrl: "https://via.placeholder.com/150",
          firstReleaseDate: 0,
          releaseDate: DateTime(2002)),
    ];

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Most Rated',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mostRated.length,
              itemBuilder: (context, index) {
                return NewReleaseCard(game: mostRated[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}
