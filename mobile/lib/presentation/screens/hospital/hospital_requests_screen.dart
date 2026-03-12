import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sangvie/core/theme/app_colors.dart';
import 'package:sangvie/presentation/widgets/hospital_layout.dart';
import 'package:sangvie/presentation/widgets/ui_components.dart';

class HospitalRequestsScreen extends StatefulWidget {
  const HospitalRequestsScreen({super.key});

  @override
  State<HospitalRequestsScreen> createState() => _HospitalRequestsScreenState();
}

class _HospitalRequestsScreenState extends State<HospitalRequestsScreen> {
  final List<Map<String, dynamic>> requests = [
    {
      'id': 1,
      'bloodGroup': 'O+',
      'quantity': 3,
      'urgency': 'critical',
      'reason': 'Accident de la route',
      'status': 'active',
      'responses': 5,
      'createdAt': 'Il y a 10 min',
    },
    {
      'id': 2,
      'bloodGroup': 'A-',
      'quantity': 2,
      'urgency': 'moderate',
      'reason': 'Intervention chirurgicale',
      'status': 'active',
      'responses': 2,
      'createdAt': 'Il y a 2h',
    },
    {
      'id': 3,
      'bloodGroup': 'B+',
      'quantity': 1,
      'urgency': 'critical',
      'reason': 'Complication accouchement',
      'status': 'fulfilled',
      'responses': 8,
      'createdAt': 'Hier',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return HospitalLayout(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SangVieTypography.h1("Demandes de sang", style: const TextStyle(fontSize: 24)),
                SangVieButton(
                  label: "Nouvelle", 
                  onPressed: () {}, 
                  height: 40,
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            SangVieTypography.h2("Demandes actives", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            ...requests.where((r) => r['status'] == 'active').map((r) => _buildRequestCard(r)),
            
            const SizedBox(height: 32),
            SangVieTypography.h2("Demandes satisfaites", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            ...requests.where((r) => r['status'] == 'fulfilled').map((r) => _buildRequestCard(r, isFulfilled: true)),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> request, {bool isFulfilled = false}) {
    final Color mainColor = isFulfilled ? AppColors.successGreen : AppColors.sangVieRed;
    
    return Opacity(
      opacity: isFulfilled ? 0.7 : 1.0,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: mainColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      request['bloodGroup'],
                      style: TextStyle(color: mainColor, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(request['reason'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(request['createdAt'], style: const TextStyle(color: Color(0xFF888888), fontSize: 12)),
                    ],
                  ),
                ),
                _buildBadge(request['urgency'], isFulfilled),
              ],
            ),
            if (!isFulfilled) ...[
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildInfo(LucideIcons.droplet, "Quantité", "${request['quantity']} poche(s)"),
                  const SizedBox(width: 24),
                  _buildInfo(LucideIcons.users, "Réponses", "${request['responses']}", valueColor: AppColors.successGreen),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: SangVieButton(label: "Réponses", onPressed: () {}, backgroundColor: AppColors.secondary, foregroundColor: AppColors.foreground, height: 36)),
                  const SizedBox(width: 12),
                  Expanded(child: SangVieButton(label: "Clôturer", onPressed: () {}, backgroundColor: AppColors.secondary, foregroundColor: AppColors.foreground, height: 36)),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String urgency, bool isFulfilled) {
    if (isFulfilled) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: AppColors.successGreen.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
        child: const Text("Satisfaite", style: TextStyle(color: AppColors.successGreen, fontSize: 10, fontWeight: FontWeight.bold)),
      );
    }
    final isCritical = urgency == 'critical';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: (isCritical ? AppColors.sangVieRed : Colors.orange).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isCritical ? "Urgence vitale" : "Urgence modérée",
        style: TextStyle(color: isCritical ? AppColors.sangVieRed : Colors.orange, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfo(IconData icon, String label, String value, {Color? valueColor}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF888888)),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Color(0xFF888888), fontSize: 10)),
            Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: valueColor)),
          ],
        ),
      ],
    );
  }
}
