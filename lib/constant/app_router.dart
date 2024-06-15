import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/presentation/screen/login_screen.dart';
import 'package:todo_app/presentation/screen/splash_screen.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/splash',
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text('404 - Page not found'),
      ),
    ),
  ),
  routes: [
    GoRoute(
      path: '/splash',
      pageBuilder: (context, state) => MaterialPage(child: SplashScreen()),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => MaterialPage(child: LoginScreen()),
    ),
  ],
);
