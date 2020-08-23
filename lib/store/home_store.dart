import 'package:flutter/foundation.dart';
import 'package:flutter_movie_trailer/core/api.dart';
import 'package:flutter_movie_trailer/core/local_datasource.dart';
import 'package:flutter_movie_trailer/core/models.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  _HomeStore({@required this.api, @required this.localDatasource}) {
    topRatedList = localDatasource.topRatedList;
    searchList = localDatasource.searchList;
    popularList = localDatasource.popularList;
    upcomingList = localDatasource.upcomingList;
    nowPlayingList = localDatasource.nowPlayingList;
  }

  final API api;
  final LocalDatasource localDatasource;

  @observable
  ObservableList<ApiMovie> searchList;

  @observable
  ObservableList<ApiMovie> topRatedList;

  @observable
  ObservableList<ApiMovie> popularList;

  @observable
  ObservableList<ApiMovie> upcomingList;

  @observable
  ObservableList<ApiMovie> nowPlayingList;

  @observable
  ApiMovie latestMovie;

  @action
  Future<void> search(String query) async {
    final response = await api.search(query);
    localDatasource.searchList.clear();
    localDatasource.searchList.addAll(response.results);
  }

  @action
  Future<void> getTopRatesMovies() async {
    final response = await api.getTopRatesMovies(1);
    localDatasource.topRatedList.clear();
    localDatasource.topRatedList.addAll(response.results);
  }

  @action
  Future<void> getPopularMovies() async {
    final response = await api.getPopularMovies(1);
    localDatasource.popularList.clear();
    localDatasource.popularList.addAll(response.results);
  }

  @action
  Future<void> getUpcomingMovies() async {
    final response = await api.getUpcomingMovies(1);
    localDatasource.upcomingList.clear();
    localDatasource.upcomingList.addAll(response.results);
  }

  @action
  Future<void> getNowPlayingMovies() async {
    final response = await api.getUpcomingMovies(1);
    localDatasource.nowPlayingList.clear();
    localDatasource.nowPlayingList.addAll(response.results);
  }

  @action
  Future<void> getLatestMovie() async {
    latestMovie = await api.getLatestMovie();
    localDatasource.latestMovie = latestMovie;
  }
}
