import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sangvie/core/theme/app_theme.dart';
import 'package:sangvie/core/services/language_service.dart';
import 'package:sangvie/presentation/screens/splash/splash_screen.dart';
import 'package:sangvie/presentation/screens/home/home_screen.dart';
import 'package:sangvie/presentation/screens/auth/login_screen.dart';
import 'package:sangvie/presentation/screens/auth/register_screen.dart';
import 'package:sangvie/presentation/screens/auth/forgot_password_screen.dart';
import 'package:sangvie/presentation/screens/donor/donor_feed_screen.dart';
import 'package:sangvie/presentation/screens/donor/donor_map_screen.dart';
import 'package:sangvie/presentation/screens/donor/donor_history_screen.dart';
import 'package:sangvie/presentation/screens/donor/donor_profile_screen.dart';
import 'package:sangvie/presentation/screens/hospital/hospital_dashboard_screen.dart';
import 'package:sangvie/presentation/screens/hospital/hospital_requests_screen.dart';
import 'package:sangvie/presentation/screens/hospital/hospital_stats_screen.dart';
import 'package:sangvie/presentation/screens/hospital/hospital_map_screen.dart';
import 'package:sangvie/presentation/screens/hospital/hospital_profile_screen.dart';
import 'package:sangvie/presentation/screens/admin/admin_dashboard_screen.dart';
import 'package:sangvie/presentation/screens/admin/admin_hospitals_screen.dart';
import 'package:sangvie/presentation/screens/admin/admin_users_screen.dart';
import 'package:sangvie/presentation/screens/admin/admin_reports_screen.dart';
import 'package:go_router/go_router.dart';

class SangVieApp extends StatelessWidget {
  const SangVieApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);

    final GoRouter _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
        GoRoute(path: '/racine', builder: (context, state) => const SplashScreen()),
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
        GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
        GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
        GoRoute(path: '/forgot-password', builder: (context, state) => const ForgotPasswordScreen()),
        
        // Donor Routes
        GoRoute(path: '/donor/feed', builder: (context, state) => const DonorFeedScreen()),
        GoRoute(path: '/donor/map', builder: (context, state) => const DonorMapScreen()),
        GoRoute(path: '/donor/history', builder: (context, state) => const DonorHistoryScreen()),
        GoRoute(path: '/donor/profile', builder: (context, state) => const DonorProfileScreen()),
        
        // Hospital Routes
        GoRoute(path: '/hospital/dashboard', builder: (context, state) => const HospitalDashboardScreen()),
        GoRoute(path: '/hospital/requests', builder: (context, state) => const HospitalRequestsScreen()),
        GoRoute(path: '/hospital/stats', builder: (context, state) => const HospitalStatsScreen()),
        GoRoute(path: '/hospital/map', builder: (context, state) => const HospitalMapScreen()),
        GoRoute(path: '/hospital/profile', builder: (context, state) => const HospitalProfileScreen()),
        
        // Admin Routes
        GoRoute(path: '/admin/dashboard', builder: (context, state) => const AdminDashboardScreen()),
        GoRoute(path: '/admin/hospitals', builder: (context, state) => const AdminHospitalsScreen()),
        GoRoute(path: '/admin/users', builder: (context, state) => const AdminUsersScreen()),
        GoRoute(path: '/admin/reports', builder: (context, state) => const AdminReportsScreen()),
      ],
    );

    return MaterialApp.router(
      title: 'SangVie',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light, // Par défaut light comme dans theme.css :root
      routerConfig: _router,
      locale: languageService.locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr', ''),
        Locale('en', ''),
      ],
      // Les localizations seront ajoutées si nécessaire via intl_translation
    );
  }
}
