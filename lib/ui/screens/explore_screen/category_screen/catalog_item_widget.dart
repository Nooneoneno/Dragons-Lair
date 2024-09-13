import 'package:DragOnPlay/ui/screens/game_details_widget/game_details_screen.dart';
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
        height: _isExpanded ? 120 : 46,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: !_isExpanded ? Colors.purpleAccent : Colors.transparent,
        ),
        child: Stack(
          children: [
            if (_isExpanded)
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
                    image: DecorationImage(
                      image: widget.game.coverUrl.isNotEmpty
                          ? NetworkImage(widget.game.coverUrl)
                          : AssetImage('assets/placeholder.jpg')
                              as ImageProvider,
                      //TODO: gestire il caricamento
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
              left: 8,
                bottom: 8,
                child: Text(
                  widget.game.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Positioned(
              right: 8,
              top: _isExpanded ? 8 : 0,
              child: Center(
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  icon: _isExpanded
                      ? Icon(Icons.keyboard_arrow_up)
                      : Icon(Icons.keyboard_arrow_down),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
