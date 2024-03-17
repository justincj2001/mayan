import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioFilePath;

  const AudioPlayerWidget({Key? key, required this.audioFilePath}) : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer;
  PlayerState _playerState = PlayerState.stopped;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        _playerState = state;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.blue[50]),
        height: 70,
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    _playerState == PlayerState.playing ? Icons.pause : Icons.play_arrow,
                  ),
                  onPressed: () {
                    if (_playerState == PlayerState.playing) {
                      _audioPlayer.pause();
                    } else {
                      _audioPlayer.play(DeviceFileSource(widget.audioFilePath));
                    }
                  },
                ),
                Container(
                  
                  width: MediaQuery.of(context).size.width-70,
                  child: Divider(color: Colors.black,))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
