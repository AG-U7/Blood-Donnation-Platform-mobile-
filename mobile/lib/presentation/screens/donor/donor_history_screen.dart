import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sangvie/core/theme/app_colors.dart';
import 'package:sangvie/presentation/widgets/donor_layout.dart';
import 'package:sangvie/presentation/widgets/ui_components.dart';

class DonorHistoryScreen extends StatelessWidget {
  const DonorHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DonorLayout(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SangVieTypography.h1("Votre historique", style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            SangVieTypography.body("Retrouvez ici la trace de tous vos dons et de vos vies sauvées."),
            
            const SizedBox(height: 32),
            
            _buildHistoryItem(
              hospital: "CHU Yalgado Ouédraogo",
              date: "12 Octobre 2023",
              status: "Validé",
              type: "Don de sang total",
            ),
            const SizedBox(height: 16),
            _buildHistoryItem(
              hospital: "Clinique Sandof",
              date: "15 Mai 2023",
              status: "Validé",
              type: "Don de plaquettes",
            ),
            const SizedBox(height: 16),
            _buildHistoryItem(
              hospital: "CMA Pissy",
              date: "02 Février 2023",
              status: "Validé",
              type: "Don de sang total",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem({required String hospital, required String date, required String status, required String type}) {
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
            decoration: BoxDecoration(color: const Color(0xFF1A7A3F).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: const Icon(LucideIcons.checkCircle, color: Color(0xFF1A7A3F), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(hospital, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(type, style: const TextStyle(color: Color(0xFF888888), fontSize: 13)),
                Text(date, style: const TextStyle(color: Color(0xFF888888), fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFFE8F5EE), borderRadius: BorderRadius.circular(4)),
            child: const Text("Vérifié", style: TextStyle(color: Color(0xFF1A7A3F), fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
