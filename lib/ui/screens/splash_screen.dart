import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import 'package:relay/ui/models/app_bootstraper_model.dart';
import 'package:relay/ui/screens/onboarding_screen.dart';
import 'package:relay/ui/transitions/fade_route.dart';
import 'package:relay/ui/app_styles.dart';
import 'package:relay/ui/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppBootstrapperModel bootstrapper;

  Completer _completer;

  @override
  void initState() {
    bootstrapper = AppBootstrapperModel();
    _completer = Completer();
    _completer.complete(bootstrapper.init(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _completer.future,
      initialData: BootstrapStatus.Initializing,
      builder: (context, snapshot) {
        String animation = bootstrapper.status == BootstrapStatus.Initializing ? "Splash_Loop" : "Splash_Ends";

        return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppStyles.primaryGradientStart, AppStyles.primaryGradientEnd],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight)),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FlareActor(
          "assets/animations/splash_screen.flr",
          fit: BoxFit.fitHeight,
          callback: (s) {
            if(bootstrapper.status == BootstrapStatus.ReadyToLaunch) {
              Navigator
                .of(context)
                .pushReplacement(
                  FadeRoute(page: HomeScreen()));
            } else if(bootstrapper.status == BootstrapStatus.RequiresOnboarding) {
              Navigator
                .of(context)
                .pushReplacement(
                  FadeRoute(page: OnboardingScreen()));
            }
          },
          animation: animation,
        )
      );
    },
    );
  }
}