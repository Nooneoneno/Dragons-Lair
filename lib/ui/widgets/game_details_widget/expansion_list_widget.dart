import 'package:GameHub/controllers/game_fetch_controller.dart';
import 'package:GameHub/entities/video_game_partial.dart';
import 'package:flutter/material.dart';

class GameExpansionList extends StatelessWidget {
  final String title;
  final List<int> gameIds;
  final Function(int) onGameTap;

  const GameExpansionList({
    super.key,
    required this.title,
    required this.gameIds,
    required this.onGameTap,
  });

  Future<VideoGamePartial> _fetchGamePartial(int id) async {
    try {
      return await GameFetchController().getPartialGame(id);
    } catch (e) {
      throw Exception("Failed to load game details");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: gameIds.map((id) {
              return FutureBuilder<VideoGamePartial>(
                future: _fetchGamePartial(id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      width: 150,
                      height: 150,
                      margin: EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blueGrey.withOpacity(0.2),
                      ),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (snapshot.hasError) {
                    return Container(
                      width: 150,
                      height: 150,
                      margin: EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.red.withOpacity(0.5),
                      ),
                      child: Center(
                        child: Icon(Icons.error, color: Colors.white),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final game = snapshot.data!;
                    return GestureDetector(
                      onTap: () => onGameTap(game.id),
                      child: Container(
                        width: 150,
                        margin: EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blueGrey.withOpacity(0.2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15)),
                                child: game.coverUrl.isNotEmpty
                                    ? Image.network(
                                        game.coverUrl,
                                        height: 150,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        'assets/placeholder.jpg',
                                        height: 150,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                game.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
