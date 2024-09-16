import 'package:dragon_lair/entities/video_game_partial.dart';
import 'package:dragon_lair/ui/screens/game_details_widget/game_details_screen.dart';
import 'package:dragon_lair/ui/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';

class CatalogItem extends StatefulWidget {
  final VideoGamePartial game;

  const CatalogItem({super.key, required this.game});

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
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: !_isExpanded
              ? const LinearGradient(
                  colors: [
                    Colors.purpleAccent,
                    Colors.blueAccent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: _isExpanded ? Colors.transparent : null,
        ),
        child: Stack(
          children: [
            if (_isExpanded)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: NetworkImageWidget(
                    imageUrl: widget.game.coverUrl,
                    boxFit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
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
                  widget.game.name.length > 34
                      ? '${widget.game.name.substring(0, 34)}...'
                      : widget.game.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                )
            ),
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
                      ? const Icon(Icons.keyboard_arrow_up)
                      : const Icon(Icons.keyboard_arrow_down),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
