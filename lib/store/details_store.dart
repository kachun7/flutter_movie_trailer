import 'package:flutter/foundation.dart';
import 'package:flutter_movie_trailer/core/api.dart';
import 'package:flutter_movie_trailer/core/local_datasource.dart';
import 'package:flutter_movie_trailer/core/models.dart';
import 'package:mobx/mobx.dart';

part 'details_store.g.dart';

class DetailsStore = _DetailsStore with _$DetailsStore;

abstract class _DetailsStore with Store {
  _DetailsStore({@required this.movieId, @required this.api, @required this.localDatasource}) {
    movie = localDatasource.getMovie(movieId);
  }

  final int movieId;
  final API api;
  final LocalDatasource localDatasource;

  @observable
  ApiMovie movie;

  @observable
  ObservableList<ApiVideo> videosList = ObservableList();

  @action
  Future<void> getVideos() async {
    final response = await api.getVideos(movieId);
    videosList.clear();
    videosList.addAll(response.results);
  }
}
