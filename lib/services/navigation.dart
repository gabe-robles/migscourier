import 'package:flutter/material.dart';

class NavigationServices {

  changeScreenReplacement(BuildContext context, String newRoute) {
    Navigator.pushNamedAndRemoveUntil(context, newRoute, (Route<dynamic> route) => false);
  }

  changeScreen(BuildContext context, String newRoute) {
    Navigator.pushNamed(context, newRoute);
  }

  Route createRoute(Widget newRoute) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => newRoute,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

}