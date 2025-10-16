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
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    try {
      final results = await YouTubeService.fetchVideos(
        '${widget.label} treatment for farmers agriculture',
      );
      setState(() {
        _videos = results;
        _isLoading = false;
        _hasError = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.shade400,
                        Colors.red.shade600,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Video Resources",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade800,
                  ),
                ),
                const Spacer(),
                if (!_isLoading && _videos.isNotEmpty)
                  IconButton(
                    onPressed: _loadVideos,
                    icon: Icon(
                      Icons.refresh_rounded,
                      size: 20,
                      color: Colors.grey.shade600,
                    ),
                    tooltip: 'Refresh videos',
                  ),
              ],
            ),
          ),

          // Content Area
          if (_isLoading) _buildLoadingState(),
          if (_hasError) _buildErrorState(),
          if (!_isLoading && !_hasError && _videos.isEmpty) _buildEmptyState(),
          if (!_isLoading && !_hasError && _videos.isNotEmpty)
            _buildVideoList(),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red.shade400),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Loading helpful videos...',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade100),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 32,
            color: Colors.red.shade400,
          ),
          const SizedBox(height: 8),
          Text(
            'Failed to load videos',
            style: TextStyle(
              color: Colors.red.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: _loadVideos,
            icon: const Icon(Icons.refresh_rounded, size: 16),
            label: const Text('Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade500,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.video_library_rounded,
            size: 32,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 8),
          Text(
            'No videos found',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Try searching with different keywords',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildVideoList() {
    return Column(
      children: [
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _videos.length,
            itemBuilder: (context, index) {
              final video = _videos[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: index == _videos.length - 1 ? 0 : 16,
                ),
                child: VideoCard(
                  videoId: video['id']!,
                  title: video['title']!,
                  thumbnail: video['thumbnail']!,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Swipe for more videos →',
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
