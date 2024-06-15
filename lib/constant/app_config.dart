import 'package:flutter/material.dart';

class AppConfig {
  // Base URL
  static const String baseApiUrl = "https://api.escuelajs.co/api/v1/";

  //
  static const String appName = "Education";
  static const bool showLog = true;
  static const supportedLocale = [
    Locale("en", "US"),
    Locale("km", "KH"),
  ];

  //
  static double tabletBreakPoint = 550;
  int? groupType = 0;
}
