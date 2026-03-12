import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:sangvie/core/services/language_service.dart';
import 'package:sangvie/core/theme/app_colors.dart';

class HospitalLayout extends StatelessWidget {
  final Widget child;

  const HospitalLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);
    final t = languageService.t;
    final location = GoRouterState.of(context).uri.toString();

    final navItems = [
      {'icon': LucideIcons.layoutDashboard, 'label': t('nav.hospital.dashboard'), 'path': '/hospital/dashboard'},
      {'icon': LucideIcons.stethoscope, 'label': t('nav.hospital.requests'), 'path': '/hospital/requests'},
      {'icon': LucideIcons.barChart3, 'label': t('nav.hospital.stats'), 'path': '/hospital/stats'},
      {'icon': LucideIcons.mapPin, 'label': t('nav.hospital.map'), 'path': '/hospital/map'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(LucideIcons.droplet, color: AppColors.sangVieRed, size: 24),
            const SizedBox(width: 8),
            const Text('SangVie Pro', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.bell, color: Color(0xFF444444)),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: AppColors.border, height: 1.0),
        ),
      ),
      // Drawer pour la navigation latérale Desktop (simulé)
      drawer: Drawer(
        child: Column(
          children: [
             DrawerHeader(
              child: Row(
                children: [
                  const Icon(LucideIcons.droplet, color: AppColors.sangVieRed, size: 32),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('SangVie', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      Text('Pro', style: TextStyle(color: AppColors.mutedForeground, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: navItems.map((item) {
                  final isActive = location.startsWith(item['path'] as String);
                  return ListTile(
                    leading: Icon(item['icon'] as IconData, color: isActive ? AppColors.sangVieRed : AppColors.mutedForeground),
                    title: Text(item['label'] as String, style: TextStyle(color: isActive ? AppColors.sangVieRed : AppColors.foreground, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
                    onTap: () => context.go(item['path'] as String),
                    selected: isActive,
                    selectedTileColor: AppColors.sangVieRed.withOpacity(0.1),
                  );
                }).toList(),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(LucideIcons.settings),
              title: Text(t('nav.hospital.profile')),
              onTap: () => context.go('/hospital/profile'),
            ),
          ],
        ),
      ),
      body: SafeArea(child: child),
      bottomNavigationBar: MediaQuery.of(context).size.width < 1024 ? Container(
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: navItems.map((item) {
            final isActive = location.startsWith(item['path'] as String);
            return GestureDetector(
              onTap: () => context.go(item['path'] as String),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item['icon'] as IconData,
                    color: isActive ? AppColors.sangVieRed : AppColors.mutedForeground,
                    size: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['label'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: isActive ? AppColors.sangVieRed : AppColors.mutedForeground,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ) : null,
    );
  }
}
