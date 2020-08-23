import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({Key key, @required this.path}) : super(key: key);

  static const String baseImageURL = 'https://image.tmdb.org/t/p/w1066_and_h600_bestv2';

  final String path;

  @override
  Widget build(BuildContext context) {
    if (path == null) {
      return Container(color: Theme.of(context).accentColor);
    }
    return Image(
      image: AdvancedNetworkImage(
        baseImageURL + path,
        useDiskCache: true,
        cacheRule: const CacheRule(maxAge: Duration(days: 7)),
      ),
      fit: BoxFit.cover,
    );
  }
}
