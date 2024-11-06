import 'package:flutter/material.dart';
import 'package:money_transact/resource/images.dart';
import 'package:money_transact/ui/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller1 = AnimationController(
    duration: const Duration(milliseconds: 900),
    vsync: this,
  );

  late final CurvedAnimation _animation1 = CurvedAnimation(
    parent: _controller1,
    curve: Curves.fastOutSlowIn,
  );

  late final AnimationController _controller2 = AnimationController(
    duration: const Duration(milliseconds: 1500),
    vsync: this,
  );

  late final CurvedAnimation _animation2 = CurvedAnimation(
    parent: _controller2,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    super.initState();
    _controller1.forward();
    _controller2.forward();
    Future.delayed(
      const Duration(milliseconds: 2100),
      () => LoginScreen.open(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FractionallySizedBox(
            widthFactor: 0.5,
            child: ScaleTransition(
              scale: _animation1,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(Images.logo),
              ),
            ),
          ),
          const SizedBox(height: 10),
          FadeTransition(
            opacity: _animation2,
            child: Text(
              'Transact',
              style: textTheme.headlineMedium!.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animation1.dispose();
    _animation2.dispose();
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }
}
