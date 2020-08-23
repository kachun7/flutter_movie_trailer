import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

typedef PageBuilder = Widget Function();

class PagesRoutes {
  static const Duration kDefaultDuration = Duration(milliseconds: 300);

  static Route<T> fadeThrough<T>(PageBuilder page, [Duration duration = kDefaultDuration]) {
    return PageRouteBuilder<T>(
      transitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => page(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeThroughTransition(animation: animation, secondaryAnimation: secondaryAnimation, child: child);
      },
    );
  }

  static Route<T> fadeScale<T>(PageBuilder page, [Duration duration = kDefaultDuration]) {
    return PageRouteBuilder<T>(
      transitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => page(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }

  static Route<T> sharedAxis<T>(
    PageBuilder page, [
    SharedAxisTransitionType type = SharedAxisTransitionType.scaled,
    Duration duration = kDefaultDuration,
  ]) {
    return PageRouteBuilder<T>(
      transitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => page(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: type,
          child: child,
        );
      },
    );
  }
}
