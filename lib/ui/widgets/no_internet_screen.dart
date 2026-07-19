import 'package:flutter/material.dart';

import '../../utils/overlay_route.dart';
import 'overlay_dialog_card.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  static Future open() async {
    return pushOverlayRouteOnce(
      routeName: "/no-internet",
      builder: (context) => const NoInternetScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return OverlayDialogCard(
      message: Text(
        'Unable to connect!\n'
        'Please check your network and try again',
        textAlign: TextAlign.center,
        style: textTheme.labelSmall,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
