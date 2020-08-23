import 'package:mobx/mobx.dart';

import 'models.dart';

part 'local_datasource.g.dart';

// Note: We should store data in the database.

class LocalDatasource = _LocalDatasource with _$LocalDatasource;

abstract class _LocalDatasource with Store {
  @observable
  ObservableList<ApiMovie> searchList = ObservableList();

  @observable
  ObservableList<ApiMovie> topRatedList = ObservableList();

  @observable
  ObservableList<ApiMovie> popularList = ObservableList();

  @observable
  ObservableList<ApiMovie> upcomingList = ObservableList();

  @observable
  ObservableList<ApiMovie> nowPlayingList = ObservableList();

  @observable
  ApiMovie latestMovie;

  ApiMovie getMovie(int movieId) {
    final list = <ApiMovie>[
      ...nowPlayingList,
      ...topRatedList,
      ...popularList,
      ...upcomingList,
      if (latestMovie != null) ...[
        latestMovie,
      ],
    ];

    return list.firstWhere((element) => element.id == movieId, orElse: () => null);
  }
}
