import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notesapp/presentation/pages/auth/login_page.dart';
import 'package:notesapp/presentation/pages/auth/register_page.dart';
import 'package:notesapp/presentation/pages/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../presentation/pages/splash/splash_page.dart';
import '../../core/constants/app_constants.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    redirect: (context, state) async {
      final prefs = await SharedPreferences.getInstance();
      final splashShown = prefs.getBool(AppConstants.splashShownKey) ?? false;
      final session = Supabase.instance.client.auth.currentSession;

      // If splash not shown, go to splash
      if (!splashShown && state.matchedLocation != AppRoutes.splash) {
        return AppRoutes.splash;
      }

      // If splash shown and user is authenticated, go to home
      if (splashShown && session != null) {
        if (state.matchedLocation != AppRoutes.login ||
            state.matchedLocation != AppRoutes.register ||
            state.matchedLocation != AppRoutes.splash) {
          return AppRoutes.home;
        }
      }

      // If splash shown and user is not authenticated
      if (splashShown && session == null) {
        if (state.matchedLocation == AppRoutes.home ||
            state.matchedLocation == AppRoutes.splash) {
          return AppRoutes.login;
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.error}'))),
  );
}
