import 'package:flutter/material.dart';

enum SlideDirection { leftToRight, rightToLeft }

class SlidePageRoute<T> extends MaterialPageRoute<T> {
  SlidePageRoute({
    required WidgetBuilder builder,
    this.slideDirection = SlideDirection.leftToRight,
    RouteSettings? settings,
  }) : super(builder: builder, settings: settings);

  final SlideDirection slideDirection;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 250);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var slideBegin = slideDirection == SlideDirection.leftToRight
        ? Offset(1.0, 0.0)
        : Offset(-1.0, 0.0);
    var slideEnd = Offset.zero;
    var curve = Curves.easeInOutCubic;

    var slide = Tween<Offset>(begin: slideBegin, end: slideEnd)
        .chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(slide),
      child: child,
    );
  }
}
