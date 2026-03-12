import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sangvie/app.dart';
import 'package:sangvie/core/services/auth_service.dart';
import 'package:sangvie/core/services/language_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialisation du service de langue (simulation de LanguageProvider)
  final languageService = LanguageService();
  await languageService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: languageService),
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const SangVieApp(),
    ),
  );
}
