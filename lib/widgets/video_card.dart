import 'package:flutter/material.dart';
import '../screens/video_player_screen.dart';

class VideoCard extends StatelessWidget {
  final String videoId;
  final String title;
  final String thumbnail;

  const VideoCard(
      {required this.videoId, required this.title, required this.thumbnail});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VideoPlayerScreen(videoId: videoId),
            ),
          );
        },
        child: Stack(
          children: [
            Card(
              elevation: 4,
              shadowColor: Colors.transparent,
              color: const Color.fromARGB(44, 147, 246, 150),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              clipBehavior:
                  Clip.antiAlias, // important for rounded image clipping
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    thumbnail,
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Image.asset(
                "assets/icons/youtube.png",
                width: 25,
                height: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
