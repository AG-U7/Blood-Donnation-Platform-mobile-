import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sangvie/core/theme/app_colors.dart';
import 'package:sangvie/presentation/widgets/hospital_layout.dart';
import 'package:sangvie/presentation/widgets/ui_components.dart';

class HospitalProfileScreen extends StatefulWidget {
  const HospitalProfileScreen({super.key});

  @override
  State<HospitalProfileScreen> createState() => _HospitalProfileScreenState();
}

class _HospitalProfileScreenState extends State<HospitalProfileScreen> {
  final Map<String, String> profile = {
    'name': 'CHU Yalgado Ouédraogo',
    'email': 'contact@chu-yo.bf',
    'phone': '+226 25 30 67 00',
    'address': 'Avenue de l\'Indépendance, Ouagadougou',
    'registrationId': 'HOS-2024-001',
    'capacity': '500 lits',
  };

  @override
  Widget build(BuildContext context) {
    return HospitalLayout(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SangVieTypography.h1("Profil hôpital", style: const TextStyle(fontSize: 24)),
                TextButton(onPressed: () {}, child: const Text("Modifier", style: TextStyle(color: AppColors.sangVieRed))),
              ],
            ),
            const SizedBox(height: 24),
            
            // Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(color: AppColors.sangVieRed.withOpacity(0.1), shape: BoxShape.circle),
                    child: const Icon(LucideIcons.building2, color: AppColors.sangVieRed, size: 40),
                  ),
                  const SizedBox(height: 16),
                  Text(profile['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text("ID: ${profile['registrationId']}", style: const TextStyle(color: Color(0xFF888888), fontSize: 14)),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Details Card
            _buildDetailSection("Informations", [
              _buildDetailItem(LucideIcons.mail, "Email", profile['email']!),
              _buildDetailItem(LucideIcons.phone, "Téléphone", profile['phone']!),
              _buildDetailItem(LucideIcons.mapPin, "Adresse", profile['address']!),
              _buildDetailItem(LucideIcons.building, "Capacité", profile['capacity']!),
            ]),
            
            const SizedBox(height: 20),
            
            // Settings Card
            _buildDetailSection("Paramètres", [
              _buildSettingItem(LucideIcons.bell, "Notifications", true),
              _buildSettingItem(LucideIcons.globe, "Langue", "Français"),
            ]),
            
            const SizedBox(height: 32),
            
            SangVieButton(
              label: "Se déconnecter", 
              onPressed: () => Navigator.of(context).pushReplacementNamed('/home'), 
              isFullWidth: true,
              backgroundColor: AppColors.secondary,
              foregroundColor: AppColors.sangVieRed,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> items) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          ...items,
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF888888)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Color(0xFF888888), fontSize: 12)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String label, dynamic trailing) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: const Color(0xFF444444)),
              const SizedBox(width: 12),
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
          if (trailing is bool)
            Switch(value: trailing, onChanged: (v) {}, activeColor: AppColors.successGreen)
          else
            Text(trailing.toString(), style: const TextStyle(color: Color(0xFF888888), fontSize: 14)),
        ],
      ),
    );
  }
}
