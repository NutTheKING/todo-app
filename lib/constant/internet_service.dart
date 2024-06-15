import 'dart:io';

import 'package:rxdart/rxdart.dart';

class InternetService {
  InternetService._internal();

  static final InternetService _instance = InternetService._internal();

  factory InternetService() {
    return _instance;
  }

  bool initialized = false;

  BehaviorSubject<bool> onInternetStatusChanged = BehaviorSubject()..add(false);

  getInstance() async {
    if (!initialized) {
      checkInternetStatus();
      initialized = true;
    }
  }

  checkInternetStatus() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        onInternetStatusChanged.add(true);
      }
    } on SocketException catch (_) {
      onInternetStatusChanged.add(false);
    } finally {
      await Future.delayed(const Duration(seconds: 5));
      checkInternetStatus();
    }
  }
}
