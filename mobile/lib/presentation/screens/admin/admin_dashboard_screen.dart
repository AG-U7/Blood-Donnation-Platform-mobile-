import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sangvie/core/theme/app_colors.dart';
import 'package:sangvie/presentation/widgets/admin_layout.dart';
import 'package:sangvie/presentation/widgets/ui_components.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SangVieTypography.h1("Dashboard Admin", style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 32),
            _buildStatsGrid(),
            const SizedBox(height: 40),
            _buildHospitalsToValidate(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    final stats = [
      {"label": "Donneurs inscrits", "value": "12,405", "icon": LucideIcons.users, "color": const Color(0xFF1A7A3F)},
      {"label": "Hôpitaux partenaires", "value": "48", "icon": LucideIcons.stethoscope, "color": AppColors.sangVieRed},
      {"label": "Dons totaux", "value": "3,210", "icon": LucideIcons.droplet, "color": Colors.blue},
      {"label": "Alertes critiques", "value": "12", "icon": LucideIcons.alertTriangle, "color": Colors.orange},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final s = stats[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: (s['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Icon(s['icon'] as IconData, color: s['color'] as Color),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(s['label'] as String, style: const TextStyle(color: Color(0xFF888888), fontSize: 12)),
                  Text(s['value'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHospitalsToValidate() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SangVieTypography.h2("Hôpitaux en attente de validation", style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 24),
          const Center(child: Text("Aucun hôpital en attente pour le moment.", style: TextStyle(color: Color(0xFF888888)))),
        ],
      ),
    );
  }
}
