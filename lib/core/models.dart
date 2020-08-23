import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@freezed
abstract class ApiPagingResults with _$ApiPagingResults {
  factory ApiPagingResults({
    int page,
    @JsonKey(name: 'total_results') int totalResults,
    @JsonKey(name: 'total_pages') int totalPages,
    List<ApiMovie> results,
  }) = _ApiPagingResults;

  factory ApiPagingResults.fromJson(Map<String, dynamic> json) => _$ApiPagingResultsFromJson(json);
}

@freezed
abstract class ApiMovie with _$ApiMovie {
  factory ApiMovie({
    double popularity,
    int id,
    bool video,
    @JsonKey(name: 'vote_count') int voteCount,
    @JsonKey(name: 'vote_average') double voteAverage,
    String title,
    @JsonKey(name: 'release_date') String releaseDate,
    @JsonKey(name: 'original_language') String originalLanguage,
    @JsonKey(name: 'original_title') String originalTitle,
    @JsonKey(name: 'genre_ids') List<int> genreIds,
    @JsonKey(name: 'backdrop_path') String backdropPath,
    bool adult,
    String overview,
    @JsonKey(name: 'poster_path') String posterPath,
  }) = _ApiMovie;

  factory ApiMovie.fromJson(Map<String, dynamic> json) => _$ApiMovieFromJson(json);
}

@freezed
abstract class ApiVideoResults with _$ApiVideoResults {
  factory ApiVideoResults({
    int id,
    List<ApiVideo> results,
  }) = _ApiVideoResults;

  factory ApiVideoResults.fromJson(Map<String, dynamic> json) => _$ApiVideoResultsFromJson(json);
}

@freezed
abstract class ApiVideo with _$ApiVideo {
  factory ApiVideo({
    String id,
    String key,
    String name,
    String site,
  }) = _ApiVideo;

  factory ApiVideo.fromJson(Map<String, dynamic> json) => _$ApiVideoFromJson(json);
}
