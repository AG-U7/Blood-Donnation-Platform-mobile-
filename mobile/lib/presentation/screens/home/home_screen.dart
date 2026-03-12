import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sangvie/core/services/language_service.dart';
import 'package:sangvie/core/theme/app_colors.dart';
import 'package:sangvie/presentation/widgets/public_layout.dart';
import 'package:sangvie/presentation/widgets/ui_components.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);
    final isFrench = languageService.locale.languageCode == 'fr';

    return PublicLayout(
      child: Stack(
        children: [
          // Background Image (simulation de homeImage)
          Opacity(
            opacity: 0.18,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/aman-chaturvedi-0ZZo5o00o80-unsplash.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ).animate().fadeIn(duration: 1500.ms).scale(begin: const Offset(1.05, 1.05), end: const Offset(1, 1)),

          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.85),
                  Colors.white.withOpacity(0.75),
                  Colors.white.withOpacity(0.88),
                ],
              ),
            ),
          ).animate().fadeIn(duration: 1000.ms),

          // Main Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.foreground,
                        height: 1.2,
                      ),
                      children: [
                        TextSpan(
                          text: isFrench 
                            ? "Le réseau solidaire de " 
                            : "The solidarity ",
                        ),
                        const TextSpan(
                          text: "don de sang",
                          style: TextStyle(color: AppColors.sangVieRed),
                        ),
                        if (!isFrench) 
                          const TextSpan(text: " network"),
                      ],
                    ),
                  ).animate().moveY(begin: 30, end: 0).fadeIn(delay: 200.ms, duration: 800.ms),
                  
                  const SizedBox(height: 24),
                  
                  SangVieTypography.body(
                    isFrench
                      ? "Rejoignez notre communauté. Répondez aux urgences de votre région et sauvez des vies en temps réel."
                      : "Join our community. Respond to emergencies in your area and help save lives in real time.",
                    textAlign: TextAlign.center,
                  ).animate().moveY(begin: 30, end: 0).fadeIn(delay: 200.ms, duration: 800.ms),

                  const SizedBox(height: 48),

                  SangVieButton(
                    label: isFrench ? "Commencer" : "Get started",
                    isFullWidth: true,
                    height: 56,
                    onPressed: () => context.push('/login'),
                  ).animate().moveY(begin: 20, end: 0).fadeIn(delay: 500.ms, duration: 600.ms),

                  const SizedBox(height: 32),

                  SangVieTypography.small(
                    isFrench
                      ? "Un geste simple qui peut sauver une vie"
                      : "A simple act that can save a life",
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
