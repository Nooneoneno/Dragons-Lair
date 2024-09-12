import 'package:DragOnPlay/ui/widgets/game_details_widget/game_details_page.dart';
import 'package:flutter/material.dart';
import 'package:DragOnPlay/entities/video_game_partial.dart';

class CatalogItem extends StatefulWidget {
  final VideoGamePartial game;

  CatalogItem({required this.game});

  @override
  _CatalogItemState createState() => _CatalogItemState();
}

class _CatalogItemState extends State<CatalogItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isExpanded) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameDetailsPage(gameId: widget.game.id),
            ),
          );
        } else {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        }
      },
      child: Container(
        height: _isExpanded ? 120 : 30,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: !_isExpanded ? Colors.amberAccent : Colors.transparent,
        ),
        child: Stack(
          children: [
            if (_isExpanded)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: widget.game.coverUrl.isNotEmpty
                          ? NetworkImage(widget.game.coverUrl)
                          : AssetImage('assets/placeholder.jpg') as ImageProvider, //TODO: gestire il caricamento
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.3),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Text(
                widget.game.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
