import 'dart:async';
import 'package:flutter_movie_trailer/core/models.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api.g.dart';

@RestApi(baseUrl: 'https://api.themoviedb.org/3')
abstract class API {
  factory API(Dio dio, {String baseUrl}) = _API;

  @GET('/search/movie')
  Future<ApiPagingResults> search(@Query('query') String query);

  @GET('/movie/top_rated')
  Future<ApiPagingResults> getTopRatesMovies(@Query('page') int page);

  @GET('/movie/popular')
  Future<ApiPagingResults> getPopularMovies(@Query('page') int page);

  @GET('/movie/upcoming')
  Future<ApiPagingResults> getUpcomingMovies(@Query('page') int page);

  @GET('/movie/latest')
  Future<ApiMovie> getLatestMovie();

  @GET('/movie/now_playing')
  Future<ApiMovie> getNowPlayingMovie();

  @GET('/movie/{movieId}/videos')
  Future<ApiVideoResults> getVideos(@Path() int movieId);
}
