import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sangvie/core/theme/app_colors.dart';
import 'package:sangvie/presentation/widgets/donor_layout.dart';
import 'package:sangvie/presentation/widgets/ui_components.dart';

class DonorProfileScreen extends StatelessWidget {
  const DonorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DonorLayout(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1627897495484-229b29feb0d5?crop=entropy&cs=tinysrgb&fit=facearea&facepad=2&w=256&h=256&q=80'),
            ),
            const SizedBox(height: 16),
            SangVieTypography.h1("John Doe", style: const TextStyle(fontSize: 24)),
            const Text("Donneur niveau Argon (12 dons)", style: TextStyle(color: Color(0xFF444444))),
            
            const SizedBox(height: 32),
            
            _buildInfoCard("Groupe Sanguin", "O+", LucideIcons.droplet, AppColors.sangVieRed),
            const SizedBox(height: 16),
            _buildInfoCard("Localisation", "Ouagadougou, Burkina Faso", LucideIcons.mapPin, Colors.blue),
            const SizedBox(height: 16),
            _buildInfoCard("Dernier don", "12 Octobre 2023", LucideIcons.calendar, Colors.orange),
            
            const SizedBox(height: 32),
            
            SangVieButton(
              label: "Modifier mon profil", 
              onPressed: () {}, 
              isFullWidth: true, 
              backgroundColor: Colors.white,
              foregroundColor: AppColors.foreground,
            ),
            const SizedBox(height: 12),
            SangVieButton(
              label: "Se déconnecter", 
              onPressed: () {}, 
              isFullWidth: true, 
              backgroundColor: AppColors.secondary,
              foregroundColor: AppColors.foreground,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Color(0xFF888888), fontSize: 12)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}
