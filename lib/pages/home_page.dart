import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_movie_trailer/core/models.dart';
import 'package:flutter_movie_trailer/pages/details_page.dart';
import 'package:flutter_movie_trailer/store/home_store.dart';
import 'package:flutter_movie_trailer/widget/image_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, @required this.store}) : super(key: key);

  static const String routeName = '/';

  final HomeStore store;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  static const double curatedListViewWidth = 200.0;
  static const double curatedListViewHeight = 160.0;

  @override
  void initState() {
    widget.store.getLatestMovie();
    widget.store.getTopRatesMovies();
    widget.store.getPopularMovies();
    widget.store.getUpcomingMovies();
    widget.store.getNowPlayingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Trailer'),
      ),
      body: Observer(
        builder: (_) {
          final mediaQuery = MediaQuery.of(context);
          return ListView(
            padding: EdgeInsets.only(bottom: mediaQuery.padding.bottom),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              if (widget.store.latestMovie != null) ...[
                _titleView('Latest Movie', mediaQuery),
                LayoutBuilder(
                  builder: (_, constraint) => _listItem(
                    widget.store.latestMovie,
                    width: constraint.maxWidth,
                    horizontalPadding: mediaQuery.padding.left + 4.0,
                  ),
                ),
              ],
              _titleView('Now Playing', mediaQuery),
              _horizontalMovies(widget.store.nowPlayingList),
              _titleView('Top Rated', mediaQuery),
              _horizontalMovies(widget.store.topRatedList),
              _titleView('Popular', mediaQuery),
              _horizontalMovies(widget.store.popularList),
              _titleView('Upcoming', mediaQuery),
              _horizontalMovies(widget.store.upcomingList),
            ],
          );
        }, // Th
      ),
    );
  }

  Widget _titleView(String title, MediaQueryData mediaQuery) => Container(
        padding: EdgeInsets.only(left: mediaQuery.padding.left + 4.0, top: 8.0),
        child: Text(title, style: Theme.of(context).textTheme.headline6),
      );

  Widget _horizontalMovies(List<ApiMovie> movies) => Container(
        height: curatedListViewHeight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => _listItem(movies[index]),
          itemCount: movies.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8.0),
        ),
      );

  Widget _listItem(
    ApiMovie movie, {
    double width = curatedListViewWidth,
    double horizontalPadding = 4.0,
  }) =>
      InkWell(
        onTap: () => Navigator.pushNamed(context, DetailsPage.routeName, arguments: movie.id),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 4.0),
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ImageWidget(path: movie.posterPath),
              const SizedBox(height: 4.0),
              Text(movie.title, maxLines: 2),
            ],
          ),
        ),
      );
}
