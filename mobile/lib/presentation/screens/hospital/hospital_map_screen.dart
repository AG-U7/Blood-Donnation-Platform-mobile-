import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sangvie/core/theme/app_colors.dart';
import 'package:sangvie/presentation/widgets/hospital_layout.dart';
import 'package:sangvie/presentation/widgets/ui_components.dart';

class HospitalMapScreen extends StatelessWidget {
  const HospitalMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HospitalLayout(
      child: Stack(
        children: [
          // Map Placeholder
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE3F2FD), Color(0xFFF5F5F5)],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(LucideIcons.map, color: Colors.blue, size: 64),
                  const SizedBox(height: 8),
                  SangVieTypography.h2("Carte des donneurs"),
                  SangVieTypography.body("Donneurs à proximité de votre établissement", style: const TextStyle(color: Color(0xFF888888))),
                ],
              ),
            ),
          ),

          // Mock Donor Markers
          _buildMarker(0.3, 0.4, 'O+'),
          _buildMarker(0.5, 0.5, 'A-'),
          _buildMarker(0.4, 0.7, 'B+'),

          // Filters
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
              ),
              child: const Row(
                children: [
                  Icon(LucideIcons.search, size: 18, color: Color(0xFF888888)),
                  SizedBox(width: 12),
                  Text("Filtrer par groupe sanguin...", style: TextStyle(color: Color(0xFF888888))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarker(double top, double left, String group) {
    return Positioned(
      top: 500 * top, // Simulation
      left: 300 * left, // Simulation
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
        ),
        child: Text(group, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
      ),
    );
  }
}
