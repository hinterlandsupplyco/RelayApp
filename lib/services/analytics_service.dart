import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/package_wrapper.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics;

  const AnalyticsService._(this._analytics);

  factory AnalyticsService() {
    var analytics = FirebaseAnalytics();
    return AnalyticsService._(analytics);
  }

  // Track an event with the given [name] and the optional [propeties]
  Future trackEvent(String name, {Map<String, dynamic> properties}) async {
    // This is not an assert because we don't want to crash over analytics.
    if(name == null || name.isEmpty) return;

    await _analytics.logEvent(name: name,parameters: properties);
  }

  RouteObserver getObserver() {
    return FirebaseAnalyticsObserver(analytics: _analytics);
  }

  Future logException(PlatformException e) async {
    Crashlytics.instance.recordError(e, StackTrace.current);
  }
}