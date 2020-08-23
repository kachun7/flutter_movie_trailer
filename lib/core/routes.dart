import 'package:flutter/material.dart';
import 'package:flutter_movie_trailer/pages/details_page.dart';
import 'package:flutter_movie_trailer/pages/home_page.dart';
import 'package:flutter_movie_trailer/pages/youtube_player_page.dart';
import 'package:flutter_movie_trailer/store/details_store.dart';
import 'package:flutter_movie_trailer/store/home_store.dart';
import 'package:get_it/get_it.dart';

import 'pages_routes.dart';

abstract class Routes {
  // ignore: missing_return
  static Route<dynamic> routes(RouteSettings settings, GetIt getIt) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomePage(store: getIt<HomeStore>()),
        );

      case DetailsPage.routeName:
        final movieId = settings.arguments as int;
        return PagesRoutes.sharedAxis<dynamic>(
          () => DetailsPage(store: getIt<DetailsStore>(param1: movieId)),
        );

      case YoutubePlayerPage.routeName:
        final youtubeVideoId = settings.arguments as String;
        return PagesRoutes.sharedAxis<dynamic>(
          () => YoutubePlayerPage(youtubeVideoId: youtubeVideoId),
        );

      // Routes not defined
      default:
        assert(true);
    }
  }
}
