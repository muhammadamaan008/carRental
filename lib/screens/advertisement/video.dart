import 'package:chewie/chewie.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayerFuture = initializeVideoPlayer();
  }

  Future<void> initializeVideoPlayer() async {
    String downloadURL = await getDownloadURL('cat_video.mp4');
    _videoPlayerController = VideoPlayerController.network(downloadURL);
    await _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      looping: true,
    );
  }

  Future<String> getDownloadURL(String filePath) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child(filePath);
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (error) {
      debugPrint('Error getting download URL: $error');
      return '';
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              width: 100.w,
              height: 100.h,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [CircularProgressIndicator(color: Colors.red),Text('Loading Video', style: TextStyle(color: Colors.white),)],),
            );
          } else {
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
}
