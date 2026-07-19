import 'package:flutter/material.dart';
import 'package:money_transact/ui/screens/splash/splash_screen.dart';

import '../../data/local/shared_prefs.dart';
import '../../utils/overlay_route.dart';
import 'overlay_dialog_card.dart';

class LoginExpiredScreen extends StatelessWidget {
  const LoginExpiredScreen({Key? key}) : super(key: key);

  static Future open() async {
    await Prefs.clearPrefs();
    return pushOverlayRouteOnce(
      routeName: "/auth-expired",
      builder: (context) => const LoginExpiredScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OverlayDialogCard(
      message: const Text(
        'Your session has been expired.\nPlease login again',
        textAlign: TextAlign.center,
      ),
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const SplashScreen(),
          ),
          (_) => false,
        );
      },
    );
  }
}
