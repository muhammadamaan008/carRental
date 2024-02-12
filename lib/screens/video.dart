import 'package:chewie/chewie.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  const Video({Key? key}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  late Future<String> _downloadUrl;

  @override
  void initState() {
    super.initState();
    _downloadUrl = getDownloadURL('cat_video.mp4');
  }

  Future<String> getDownloadURL(String filePath) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child(filePath);
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (error) {
      print('Error getting download URL: $error');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<String>(
        future: _downloadUrl,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            _videoPlayerController =
                VideoPlayerController.network(snapshot.data!);
            _chewieController = ChewieController(
              videoPlayerController: _videoPlayerController,
              autoPlay: true,
              looping: true,
            );
            _videoPlayerController.initialize().then((_) {
              setState(() {}); // Trigger rebuild once video player is initialized
            });
            return Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Chewie(controller: _chewieController),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
