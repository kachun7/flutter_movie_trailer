import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerPage extends StatefulWidget {
  const YoutubePlayerPage({Key key, this.youtubeVideoId}) : super(key: key);

  static const String routeName = '/youtubePlayer';

  final String youtubeVideoId;

  @override
  _YoutubePlayerPageState createState() => _YoutubePlayerPageState();
}

class _YoutubePlayerPageState extends State<YoutubePlayerPage> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(initialVideoId: widget.youtubeVideoId, flags: const YoutubePlayerFlags());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: false,
        progressIndicatorColor: Colors.amber,
        progressColors: ProgressBarColors(playedColor: Colors.amber, handleColor: Colors.amberAccent),
        onEnded: (_) => Navigator.of(context).pop(),
        topActions: <Widget>[_closeButton()],
      ),
    );
  }

  Widget _closeButton() => IconButton(
        icon: CircleAvatar(
          child: Icon(Icons.close, color: Colors.white),
        ),
        onPressed: () => Navigator.of(context).pop(),
      );
}
