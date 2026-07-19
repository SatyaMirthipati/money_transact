import 'package:flutter/material.dart';

import '../app.dart';

/// Pushes a fullscreen overlay [PageRouteBuilder] identified by [routeName],
/// ensuring the same overlay is never stacked more than once.
Future<T?> pushOverlayRouteOnce<T>({
  required String routeName,
  required WidgetBuilder builder,
}) async {
  await Future.delayed(const Duration());

  bool isNewRouteSameAsCurrent = false;
  navigatorKey.currentState?.popUntil((route) {
    if (route.settings.name == routeName) {
      isNewRouteSameAsCurrent = true;
    }
    return true;
  });

  if (isNewRouteSameAsCurrent) return null;
  return navigatorKey.currentState?.push(
    PageRouteBuilder<T>(
      pageBuilder: (context, _, __) => builder(context),
      opaque: false,
      fullscreenDialog: true,
      settings: RouteSettings(name: routeName),
    ),
  );
}
