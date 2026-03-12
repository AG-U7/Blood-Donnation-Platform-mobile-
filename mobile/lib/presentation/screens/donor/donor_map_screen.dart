import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sangvie/core/theme/app_colors.dart';
import 'package:sangvie/presentation/widgets/donor_layout.dart';
import 'package:sangvie/presentation/widgets/ui_components.dart';

class DonorMapScreen extends StatefulWidget {
  const DonorMapScreen({super.key});

  @override
  State<DonorMapScreen> createState() => _DonorMapScreenState();
}

class _DonorMapScreenState extends State<DonorMapScreen> {
  int? _selectedHospitalId;

  final List<Map<String, dynamic>> hospitals = [
    {
      'id': 1,
      'name': 'CHU Yalgado Ouédraogo',
      'distance': '2.5 km',
      'urgentNeeds': ['O+', 'A-'],
      'top': 0.3,
      'left': 0.4,
    },
    {
      'id': 2,
      'name': 'Clinique Sandof',
      'distance': '5.1 km',
      'urgentNeeds': ['B+'],
      'top': 0.5,
      'left': 0.5,
    },
    {
      'id': 3,
      'name': 'CMA Pissy',
      'distance': '7.8 km',
      'urgentNeeds': ['O+', 'AB-'],
      'top': 0.7,
      'left': 0.6,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DonorLayout(
      child: Stack(
        children: [
          // Map Placeholder
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE8F5E9), Color(0xFFF5F5F5)],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(LucideIcons.mapPin, color: AppColors.sangVieRed, size: 64),
                  const SizedBox(height: 8),
                  SangVieTypography.h2("Carte des hôpitaux"),
                  SangVieTypography.body("Centres de collecte autour de vous", style: const TextStyle(color: Color(0xFF888888))),
                ],
              ),
            ),
          ),

          // Mock Markers
          ...hospitals.map((hospital) {
            final isSelected = _selectedHospitalId == hospital['id'];
            return Positioned(
              top: MediaQuery.of(context).size.height * hospital['top'],
              left: MediaQuery.of(context).size.width * hospital['left'],
              child: GestureDetector(
                onTap: () => setState(() => _selectedHospitalId = hospital['id']),
                child: AnimatedScale(
                  scale: isSelected ? 1.2 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.sangVieRed,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2))],
                    ),
                    child: const Icon(LucideIcons.mapPin, color: Colors.white, size: 20),
                  ),
                ),
              ),
            );
          }),

          // My Location Button
          Positioned(
            top: 20,
            right: 20,
            child: FloatingActionButton.small(
              onPressed: () {},
              backgroundColor: Colors.white,
              elevation: 4,
              child: const Icon(LucideIcons.navigation, color: AppColors.sangVieRed, size: 20),
            ),
          ),

          // Info Cards
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.white, Colors.white.withOpacity(0.9), Colors.transparent],
                  stops: const [0.6, 0.8, 1.0],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: hospitals
                    .where((h) => _selectedHospitalId == null || h['id'] == _selectedHospitalId)
                    .map((hospital) => _buildHospitalCard(hospital))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHospitalCard(Map<String, dynamic> hospital) {
    final isSelected = _selectedHospitalId != null;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(hospital['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(LucideIcons.mapPin, size: 14, color: Color(0xFF888888)),
                        const SizedBox(width: 4),
                        Text(hospital['distance'], style: const TextStyle(color: Color(0xFF888888), fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              if (isSelected)
                TextButton(
                  onPressed: () => setState(() => _selectedHospitalId = null),
                  child: const Text("Fermer", style: TextStyle(color: AppColors.sangVieRed)),
                ),
            ],
          ),
          const SizedBox(height: 16),
          const Text("Besoins urgents :", style: TextStyle(color: Color(0xFF888888), fontSize: 12)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: (hospital['urgentNeeds'] as List<String>)
                .map((group) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.sangVieRed.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(group, style: const TextStyle(color: AppColors.sangVieRed, fontSize: 12, fontWeight: FontWeight.bold)),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: SangVieButton(label: "Itinéraire", onPressed: () {}, height: 40)),
              const SizedBox(width: 12),
              Expanded(child: SangVieButton(label: "Appeler", onPressed: () {}, backgroundColor: AppColors.secondary, foregroundColor: AppColors.foreground, height: 40)),
            ],
          ),
        ],
      ),
    );
  }
}
