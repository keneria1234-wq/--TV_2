import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const StreamApp());
}

class StreamApp extends StatelessWidget {
  const StreamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'منصة البث الشاملة',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const MatchesScreen(),
    const MoviesScreen(),
    const SeriesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('منصة البث الشاملة'),
        centerTitle: true,
        backgroundColor: const Color(0xFF1F1F1F),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: const Color(0xFF1F1F1F),
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: 'المباريات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'الأفلام',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'المسلسلات',
          ),
        ],
      ),
    );
  }
}

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> matches = [
      {
        'team1': 'ريال مدريد',
        'team2': 'برشلونة',
        'time': '10:00 مساءً',
        'channel': 'beIN Sports 1',
        'url': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
      },
      {
        'team1': 'ليفربول',
        'team2': 'مانشستر سيتي',
        'time': '08:00 مساءً',
        'channel': 'beIN Sports 2',
        'url': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: matches.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Text(
              'المباريات الحية اليوم',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        }
        final match = matches[index - 1];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const Icon(Icons.live_tv, color: Colors.redAccent, size: 36),
            title: Text('${match['team1']} vs ${match['team2']}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('الموعد: ${match['time']} | القناة: ${match['channel']}'),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerScreen(
                      title: '${match['team1']} vs ${match['team2']}',
                      videoUrl: match['url']!,
                    ),
                  ),
                );
              },
              child: const Text('مشاهدة'),
            ),
          ),
        );
      },
    );
  }
}

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> movies = [
      {
        'title': 'فيلم أجنبي: الأكشن والغموض',
        'type': 'أجنبي',
        'url': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
      },
      {
        'title': 'فيلم عربي: كوميديا الموسم',
        'type': 'عربي',
        'url': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
      },
      {
        'title': 'فيلم أجنبي: خيال علمي',
        'type': 'أجنبي',
        'url': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
      },
      {
        'title': 'فيلم عربي: دراما تاريخية',
        'type': 'عربي',
        'url': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
      },
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoPlayerScreen(
                  title: movie['title']!,
                  videoUrl: movie['url']!,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(8)),
                    ),
                    child: const Center(
                      child: Icon(Icons.play_circle_fill,
                          size: 50, color: Colors.redAccent),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movie['title']!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Text('التصنيف: ${movie['type']}',
                          style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SeriesScreen extends StatelessWidget {
  const SeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> seriesList = [
      {
        'title': 'مسلسل أجنبي مترجم - الموسم الأول',
        'episodes': '10 حلقات متوفرة',
        'url': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
      },
      {
        'title': 'مسلسل عربي رمضاني - الموسم الثاني',
        'episodes': '30 حلقة متوفرة',
        'url': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: seriesList.length,
      itemBuilder: (context, index) {
        final series = seriesList[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading:
                const Icon(Icons.video_library, color: Colors.blueAccent, size: 36),
            title: Text(series['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(series['episodes']!),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(
                    title: series['title']!,
                    videoUrl: series['url']!,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String title;
  final String videoUrl;

  const VideoPlayerScreen(
      {super.key, required this.title, required this.videoUrl});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
          _controller.play();
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: _isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    VideoPlayer(_controller),
                    VideoProgressIndicator(_controller, allowScrubbing: true),
                  ],
                ),
              )
            : const CircularProgressIndicator(color: Colors.red),
      ),
      floatingActionButton: _isInitialized
          ? FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            )
          : null,
    );
  }
}
