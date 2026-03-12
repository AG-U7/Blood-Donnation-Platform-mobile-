import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:sangvie/core/services/language_service.dart';
import 'package:sangvie/core/theme/app_colors.dart';

class AdminLayout extends StatelessWidget {
  final Widget child;

  const AdminLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);
    final t = languageService.t;
    final location = GoRouterState.of(context).uri.toString();

    final navItems = [
      {'icon': LucideIcons.layoutDashboard, 'label': t('nav.admin.dashboard'), 'path': '/admin/dashboard'},
      {'icon': LucideIcons.stethoscope, 'label': t('nav.admin.hospitals'), 'path': '/admin/hospitals'},
      {'icon': LucideIcons.user, 'label': t('nav.admin.users'), 'path': '/admin/users'},
      {'icon': LucideIcons.barChart3, 'label': t('nav.admin.reports'), 'path': '/admin/reports'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111111),
        foregroundColor: Colors.white,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: AppColors.sangVieRed, borderRadius: BorderRadius.circular(4)),
              child: const Icon(LucideIcons.shieldCheck, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            const Text('SangVie Admin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0xFF333333), height: 1.0),
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF111111),
        child: Column(
          children: [
            const SizedBox(height: 48),
            Expanded(
              child: ListView(
                children: navItems.map((item) {
                  final isActive = location.startsWith(item['path'] as String);
                  return ListTile(
                    leading: Icon(
                      item['icon'] as IconData, 
                      color: isActive ? AppColors.sangVieRed : const Color(0xFF888888),
                    ),
                    title: Text(
                      item['label'] as String, 
                      style: TextStyle(
                        color: isActive ? Colors.white : const Color(0xFF888888), 
                        fontWeight: isActive ? FontWeight.bold : FontWeight.normal
                      ),
                    ),
                    onTap: () => context.go(item['path'] as String),
                    selected: isActive,
                    selectedTileColor: const Color(0xFF333333),
                  );
                }).toList(),
              ),
            ),
            const Divider(color: Color(0xFF333333)),
            ListTile(
              leading: const CircleAvatar(backgroundColor: AppColors.sangVieRed, child: Text("SA", style: TextStyle(color: Colors.white, fontSize: 12))),
              title: const Text("Super Admin", style: TextStyle(color: Colors.white)),
              subtitle: const Text("Déconnexion", style: TextStyle(color: Color(0xFF888888), fontSize: 12)),
              onTap: () => context.go('/login'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      body: SafeArea(child: child),
    );
  }
}
