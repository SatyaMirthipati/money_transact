import 'package:flutter/material.dart';

import '../../resource/images.dart';
import 'custom_card.dart';

/// A centered, non-dismissible overlay card showing the app logo, a [message]
/// and a single action button. Used for blocking status dialogs such as the
/// "session expired" and "no internet" screens.
class OverlayDialogCard extends StatelessWidget {
  final Widget message;
  final String buttonText;
  final VoidCallback onPressed;

  const OverlayDialogCard({
    Key? key,
    required this.message,
    required this.onPressed,
    this.buttonText = 'OK',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Container(
        color: Colors.black54,
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.7,
            child: CustomCard(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(Images.logo, height: 160),
                    const SizedBox(height: 16),
                    message,
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: onPressed,
                      child: Text(buttonText),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
