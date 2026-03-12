import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sangvie/core/theme/app_colors.dart';
import 'package:sangvie/presentation/widgets/admin_layout.dart';
import 'package:sangvie/presentation/widgets/ui_components.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  final List<Map<String, dynamic>> users = [
    {
      'id': 1,
      'name': 'Jean Dupont',
      'phone': '+226 70 12 34 56',
      'bloodGroup': 'O+',
      'status': 'active',
      'donations': 3,
      'lastDonation': '15 Fév 2026',
      'date': 'Sept 2025',
    },
    {
      'id': 2,
      'name': 'Marie Kaboré',
      'phone': '+226 75 23 45 67',
      'bloodGroup': 'A+',
      'status': 'active',
      'donations': 5,
      'lastDonation': '01 Mar 2026',
      'date': 'Juin 2025',
    },
    {
      'id': 3,
      'name': 'Paul Ouédraogo',
      'phone': '+226 78 34 56 78',
      'bloodGroup': 'B+',
      'status': 'inactive',
      'donations': 1,
      'lastDonation': '10 Jan 2025',
      'date': 'Jan 2025',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SangVieTypography.h1("Gestion donneurs", style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            
            const SangVieInput(
              hint: "Rechercher par nom ou téléphone...", 
              prefixIcon: Icon(LucideIcons.search, size: 18),
            ),
            const SizedBox(height: 24),
            
            Row(
              children: [
                Expanded(child: _buildKPI("Total", users.length.toString(), null)),
                const SizedBox(width: 12),
                Expanded(child: _buildKPI("Actifs", "2", AppColors.successGreen)),
                const SizedBox(width: 12),
                Expanded(child: _buildKPI("Dons/Mois", "24", AppColors.sangVieRed)),
              ],
            ),
            
            const SizedBox(height: 24),
            
            ...users.map((u) => _buildUserCard(u)),
          ],
        ),
      ),
    );
  }

  Widget _buildKPI(String label, String value, Color? color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF888888), fontSize: 10)),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildUserCard(Map<String, dynamic> u) {
    final isActive = u['status'] == 'active';
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(color: AppColors.sangVieRed.withOpacity(0.1), shape: BoxShape.circle),
                    child: const Icon(LucideIcons.user, color: AppColors.sangVieRed, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(u['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(u['phone'], style: const TextStyle(color: Color(0xFF888888), fontSize: 12)),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(color: AppColors.sangVieRed.withOpacity(0.1), shape: BoxShape.circle),
                    child: Center(child: Text(u['bloodGroup'], style: const TextStyle(color: AppColors.sangVieRed, fontWeight: FontWeight.bold, fontSize: 12))),
                  ),
                  const SizedBox(width: 8),
                  _buildStatusBadge(u['status']),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStat(LucideIcons.droplet, "Dons", u['donations'].toString()),
              _buildStat(LucideIcons.calendar, "Dernier", u['lastDonation']),
              _buildStat(null, "Depuis", u['date']),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: SangVieButton(label: "Profil", onPressed: () {}, backgroundColor: AppColors.secondary, foregroundColor: AppColors.foreground, height: 32)),
              const SizedBox(width: 8),
              Expanded(child: SangVieButton(label: "Historique", onPressed: () {}, backgroundColor: AppColors.secondary, foregroundColor: AppColors.foreground, height: 32)),
              const SizedBox(width: 8),
              Expanded(child: SangVieButton(label: "Contact", onPressed: () {}, backgroundColor: AppColors.secondary, foregroundColor: AppColors.foreground, height: 32)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final isActive = status == 'active';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (isActive ? AppColors.successGreen : Colors.grey).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(isActive ? "Actif" : "Inactif", style: TextStyle(color: isActive ? AppColors.successGreen : Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildStat(IconData? icon, String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF888888), fontSize: 10)),
        Row(
          children: [
            if (icon != null) ...[Icon(icon, size: 12, color: icon == LucideIcons.droplet ? AppColors.sangVieRed : const Color(0xFF888888)), const SizedBox(width: 4)],
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
      ],
    );
  }
}
