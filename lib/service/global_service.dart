import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todo_app/constant/app_config.dart';

class GlobalService {
  GlobalService._internal();

  static final GlobalService _instance = GlobalService._internal();

  factory GlobalService() {
    return _instance;
  }

  MediaQueryData get screenPhone {
    final ctx = context;
    if (ctx != null) {
      return MediaQuery.of(ctx);
    } else {
      throw Exception("Context is not available");
    }
  }

  bool get isTabletScreen {
    final ctx = context;
    if (ctx != null) {
      return MediaQuery.of(ctx).size.shortestSide > AppConfig.tabletBreakPoint;
    } else {
      throw Exception("Context is not available");
    }
  }

  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigator => _navigator;

  BuildContext? get context => _navigator.currentContext;

  double listViewCatchExtend = 5000;
  String accessToken = "";

  bool get isUserLoggedIn => accessToken.isNotEmpty;

  Future<dynamic> pushNavigation(Widget target, {bool fullscreenDialog = false}) async {
    return await _navigator.currentState?.push(
      MaterialPageRoute(
        builder: (context) => target,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }

  void pushReplacementNavigation(Widget target) {
    _navigator.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => target),
    );
  }

  void popNavigation({dynamic result}) {
    _navigator.currentState?.pop(result);
  }

  void clearNavigationStack() {
    _navigator.currentState?.popUntil((route) => route.isFirst);
  }

  static void validateHttpResult(String? code, String? message) {
    if (code == '200') {
      return;
    }
    if (message != null && message.isNotEmpty) {
      throw HttpException(message);
    } else {
      throw Exception("something_went_wrong_try_again");
    }
  }
}
