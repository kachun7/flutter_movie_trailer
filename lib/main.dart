import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'core/injectable.dart';
import 'core/routes.dart';

Future<void> main() async {
  await setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Trailer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // ignore: missing_return
      onGenerateRoute: (settings) => Routes.routes(settings, GetIt.instance),
    );
  }
}
