import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sangvie/core/theme/app_colors.dart';
import 'package:sangvie/presentation/widgets/admin_layout.dart';
import 'package:sangvie/presentation/widgets/ui_components.dart';

class AdminHospitalsScreen extends StatefulWidget {
  const AdminHospitalsScreen({super.key});

  @override
  State<AdminHospitalsScreen> createState() => _AdminHospitalsScreenState();
}

class _AdminHospitalsScreenState extends State<AdminHospitalsScreen> {
  final List<Map<String, dynamic>> hospitals = [
    {
      'id': 1,
      'name': 'CHU Yalgado Ouédraogo',
      'location': 'Ouagadougou',
      'status': 'verified',
      'requests': 12,
      'donations': 48,
      'date': 'Jan 2024',
    },
    {
      'id': 2,
      'name': 'Clinique Sandof',
      'location': 'Ouagadougou',
      'status': 'verified',
      'requests': 8,
      'donations': 32,
      'date': 'Fév 2024',
    },
    {
      'id': 3,
      'name': 'CMA Pissy',
      'location': 'Ouagadougou',
      'status': 'pending',
      'requests': 5,
      'donations': 15,
      'date': 'Mar 2026',
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
            SangVieTypography.h1("Gestion hôpitaux", style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            
            // Search
            const SangVieInput(hint: "Rechercher un hôpital...", prefixIcon: Icon(LucideIcons.search, size: 18)),
            const SizedBox(height: 24),
            
            // KPI Bar
            Row(
              children: [
                Expanded(child: _buildKPI("Total", "3", null)),
                const SizedBox(width: 12),
                Expanded(child: _buildKPI("Vérifiés", "2", AppColors.successGreen)),
                const SizedBox(width: 12),
                Expanded(child: _buildKPI("Attente", "1", AppColors.warningOrange)),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // List
            ...hospitals.map((h) => _buildHospitalCard(h)),
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

  Widget _buildHospitalCard(Map<String, dynamic> h) {
    final isVerified = h['status'] == 'verified';
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
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(color: AppColors.sangVieRed.withOpacity(0.1), shape: BoxShape.circle),
                    child: const Icon(LucideIcons.building2, color: AppColors.sangVieRed, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(h['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          const Icon(LucideIcons.mapPin, size: 12, color: Color(0xFF888888)),
                          const SizedBox(width: 4),
                          Text(h['location'], style: const TextStyle(color: Color(0xFF888888), fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              _buildStatusBadge(h['status']),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStat("Demandes", h['requests'].toString()),
              _buildStat("Dons", h['donations'].toString()),
              _buildStat("Depuis", h['date'].toString()),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: SangVieButton(label: "Détails", onPressed: () {}, backgroundColor: AppColors.secondary, foregroundColor: AppColors.foreground, height: 32)),
              if (!isVerified) ...[
                const SizedBox(width: 8),
                Expanded(child: SangVieButton(label: "Approuver", onPressed: () {}, height: 32)),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final isVerified = status == 'verified';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (isVerified ? AppColors.successGreen : AppColors.warningOrange).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isVerified ? LucideIcons.checkCircle2 : LucideIcons.xCircle, size: 12, color: isVerified ? AppColors.successGreen : AppColors.warningOrange),
          const SizedBox(width: 4),
          Text(isVerified ? "Vérifié" : "Attente", style: TextStyle(color: isVerified ? AppColors.successGreen : AppColors.warningOrange, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF888888), fontSize: 10)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
