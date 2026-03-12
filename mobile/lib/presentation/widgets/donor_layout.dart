import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:sangvie/core/services/language_service.dart';
import 'package:sangvie/core/theme/app_colors.dart';

class DonorLayout extends StatelessWidget {
  final Widget child;

  const DonorLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);
    final t = languageService.t;
    final location = GoRouterState.of(context).uri.toString();

    final navItems = [
      {'icon': LucideIcons.home, 'label': t('nav.donor.home'), 'path': '/donor/feed'},
      {'icon': LucideIcons.mapPin, 'label': t('nav.donor.map'), 'path': '/donor/map'},
      {'icon': LucideIcons.clock, 'label': t('nav.donor.history'), 'path': '/donor/history'},
      {'icon': LucideIcons.user, 'label': t('nav.donor.profile'), 'path': '/donor/profile'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(LucideIcons.droplet, color: AppColors.sangVieRed, size: 24),
            const SizedBox(width: 8),
            const Text('SangVie', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Stack(
              children: [
                Icon(LucideIcons.bell, color: Color(0xFF444444)),
                Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(radius: 4, backgroundColor: Colors.red),
                ),
              ],
            ),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1627897495484-229b29feb0d5?crop=entropy&cs=tinysrgb&fit=facearea&facepad=2&w=256&h=256&q=80'),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: AppColors.border, height: 1.0),
        ),
      ),
      body: child,
      bottomNavigationBar: Container(
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.border)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2))
          ],
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
      ),
    );
  }
}
