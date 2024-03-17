import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:hive/hive.dart';
import 'package:mayan/providers/eventProvider.dart';
import 'package:mayan/screens/add_files_image.dart';
import 'package:mayan/screens/add_files_video.dart';
import 'package:mayan/widgets/audioplayer.dart';
import 'package:mayan/widgets/videoplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  // var data;
  var index;
  VideoScreen({super.key,this.index});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}
class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(
      builder: (context, eventProvider, child) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(Icons.circle, color: Colors.cyan, size: 40),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Videos",
                      style: TextStyle(fontSize: 27),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              eventProvider.eventdata[widget.index]["eventVideos"].isEmpty
                  ? Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 400,
                          child: Image.network("https://cdn3d.iconscout.com/3d/premium/thumb/no-data-found-4810740-4009512.png"),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddFilesVideoScreen(eventProvider.eventdata[widget.index], widget.index)));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 140,
                            decoration: BoxDecoration(color: Colors.cyan, borderRadius: BorderRadius.circular(9)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.add),
                                  Text(
                                    "Add Videos",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: eventProvider.eventdata[widget.index]["eventVideos"].length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: VideoDisplay(videopath: eventProvider.eventdata[widget.index]["eventVideos"][index]),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}

class VideoDisplay extends StatefulWidget {
  final File videopath;

  VideoDisplay({Key? key, required this.videopath}) : super(key: key);

  @override
  State<VideoDisplay> createState() => _VideoDisplayState();
}

class _VideoDisplayState extends State<VideoDisplay> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videopath.path))
      ..initialize().then((_) {
        // Once the video is initialized, we can determine the aspect ratio
        double aspectRatio = _controller.value.aspectRatio;
        print('Aspect Ratio: $aspectRatio');
        setState(() {});
      });
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Container(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  VideoPlayer(_controller),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        _downloadVideo(widget.videopath.path);
                      },
                      icon: Icon(Icons.download_for_offline_rounded, size: 50, color: Colors.amber),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  void _downloadVideo(String videoPath) async {
    try {
      await GallerySaver.saveVideo(videoPath);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Video downloaded successfully.'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to download video.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

