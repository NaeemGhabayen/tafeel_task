import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tafeel_task/utils/color_resources.dart';

ThemeData light = ThemeData(
  fontFamily: 'Alexandria',
  primaryColor: const Color(0xFF1BA4A9),
  scaffoldBackgroundColor: grey11,
  // brightness: Brightness.light,
  canvasColor: Colors.transparent,
  highlightColor: Colors.white,
  hintColor: const Color(0xFF9E9E9E),
  cupertinoOverrideTheme: NoDefaultCupertinoThemeData(primaryColor: primary),
  textSelectionTheme: const TextSelectionThemeData(
      cursorColor: primary,
      selectionColor: primary,
      selectionHandleColor: white),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    color: black,
    // color: Color(0xFF141414),
    foregroundColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      //<-- SEE HERE
      // Status bar color
      statusBarColor: white,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  ),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
