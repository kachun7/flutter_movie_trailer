import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_movie_trailer/core/models.dart';
import 'package:flutter_movie_trailer/store/details_store.dart';
import 'package:flutter_movie_trailer/widget/image_widget.dart';

import 'youtube_player_page.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key key, this.store}) : super(key: key);

  static const String routeName = '/details';

  final DetailsStore store;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    widget.store.getVideos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(
          builder: (_) => Text(widget.store.movie?.title ?? ''),
        ),
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (_, orientation) => Observer(
            builder: (_) {
              final movie = widget.store.movie;
              if (movie == null) return const Center(child: CircularProgressIndicator());
              return Stack(
                children: <Widget>[
                  if (orientation == Orientation.landscape) ...[
                    Positioned(left: 8.0, top: 8.0, width: 200.0, child: ImageWidget(path: movie.posterPath)),
                  ],
                  Positioned(
                    left: orientation == Orientation.portrait ? 0 : 208.0,
                    top: 0,
                    right: 0,
                    bottom: 0,
                    child: ListView(
                      children: <Widget>[
                        if (orientation == Orientation.portrait) ...[ImageWidget(path: movie.posterPath)],
                        ..._content(movie),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _content(ApiMovie movie) => [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(movie.overview),
        ),
        if (widget.store.videosList?.isNotEmpty ?? false) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text('Trailer', style: Theme.of(context).textTheme.headline6),
          ),
          ...widget.store.videosList.map((e) => _videoView(e)).toList(),
        ],
      ];

  Widget _videoView(ApiVideo video) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, YoutubePlayerPage.routeName, arguments: video.key),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          video.name,
          style: Theme.of(context).textTheme.bodyText1.apply(decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}
