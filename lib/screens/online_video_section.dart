import 'package:flutter/material.dart';
import '../services/youtube_service.dart';
import '../widgets/video_card.dart';

class OnlineVideoSection extends StatefulWidget {
  final String label;

  const OnlineVideoSection({required this.label});

  @override
  State<OnlineVideoSection> createState() => _OnlineVideoSectionState();
}

class _OnlineVideoSectionState extends State<OnlineVideoSection> {
  List<Map<String, String>> _videos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    final results = await YouTubeService.fetchVideos(
      '${widget.label} treatment for farmers',
    );
    setState(() {
      _videos = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (_videos.isEmpty) {
      return Center(child: Text("No videos found for this disease."));
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 175,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _videos.length,
              itemBuilder: (context, index) {
                final video = _videos[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: VideoCard(
                    videoId: video['id']!,
                    title: video['title']!,
                    thumbnail: video['thumbnail']!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
