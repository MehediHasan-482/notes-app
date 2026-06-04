import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notesapp/presentation/pages/auth/login_page.dart';
import 'package:notesapp/presentation/pages/auth/register_page.dart';
import 'package:notesapp/presentation/pages/home/home_page.dart';
import 'package:notesapp/presentation/pages/notes/add_note_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../presentation/pages/splash/splash_page.dart';
import '../../core/constants/app_constants.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String note = '/add-note';
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    redirect: (context, state) async {
      final prefs = await SharedPreferences.getInstance();
      final splashShown = prefs.getBool(AppConstants.splashShownKey) ?? false;
      final session = Supabase.instance.client.auth.currentSession;
      final currentLocation = state.matchedLocation;

      // Splash not shown yet
      if (!splashShown) {
        if (currentLocation != AppRoutes.splash) {
          return AppRoutes.splash;
        }
        return null;
      }

      // User is logged in - go to home
      if (session != null) {
        if (currentLocation == AppRoutes.login ||
            currentLocation == AppRoutes.register ||
            currentLocation == AppRoutes.splash) {
          return AppRoutes.home;
        }
        return null;
      }

      // User is not logged in - go to login
      if (session == null && splashShown) {
        if (currentLocation != AppRoutes.login &&
            currentLocation != AppRoutes.register) {
          return AppRoutes.login;
        }
        return null;
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
      GoRoute(
        path: AppRoutes.note,
        builder: (context, state) => const AddNotePage(),
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.error}'))),
  );
}
