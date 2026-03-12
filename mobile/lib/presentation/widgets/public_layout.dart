import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:sangvie/core/services/language_service.dart';
import 'package:sangvie/core/theme/app_colors.dart';

class PublicLayout extends StatelessWidget {
  final Widget child;

  const PublicLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(LucideIcons.droplet, color: AppColors.sangVieRed, size: 24),
            const SizedBox(width: 8),
            Text(
              'SangVie',
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => languageService.setLanguage('fr'),
            child: Text(
              'FR',
              style: TextStyle(
                color: languageService.locale.languageCode == 'fr' 
                  ? AppColors.foreground 
                  : AppColors.mutedForeground,
                fontWeight: languageService.locale.languageCode == 'fr' 
                  ? FontWeight.bold 
                  : FontWeight.normal,
              ),
            ),
          ),
          const Text('|', style: TextStyle(color: AppColors.border)),
          TextButton(
            onPressed: () => languageService.setLanguage('en'),
            child: Text(
              'EN',
              style: TextStyle(
                color: languageService.locale.languageCode == 'en' 
                  ? AppColors.foreground 
                  : AppColors.mutedForeground,
                fontWeight: languageService.locale.languageCode == 'en' 
                  ? FontWeight.bold 
                  : FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: AppColors.border, height: 1.0),
        ),
      ),
      body: SafeArea(child: child),
    );
  }
}

// Les autres layouts (Donor, Hospital, Admin) seront ajoutés au fur et à mesure
