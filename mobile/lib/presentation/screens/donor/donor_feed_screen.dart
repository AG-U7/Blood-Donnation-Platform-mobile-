import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sangvie/core/theme/app_colors.dart';
import 'package:sangvie/data/models/blood_request_model.dart';
import 'package:sangvie/data/repositories/blood_request_repository.dart';
import 'package:sangvie/presentation/widgets/donor_layout.dart';
import 'package:sangvie/presentation/widgets/ui_components.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DonorFeedScreen extends StatefulWidget {
  const DonorFeedScreen({super.key});

  @override
  State<DonorFeedScreen> createState() => _DonorFeedScreenState();
}

class _DonorFeedScreenState extends State<DonorFeedScreen> {
  final BloodRequestRepository _repository = BloodRequestRepository();
  bool _isActive = true;
  BloodRequest? _selectedRequest;

  @override
  Widget build(BuildContext context) {
    return DonorLayout(
      child: FutureBuilder<List<BloodRequest>>(
        future: _repository.getUrgentRequests(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final demandes = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Statut Donneur Toggle
                _buildStatusToggle(),
                
                const SizedBox(height: 24),
                
                // Header List
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SangVieTypography.h2("Urgences autour de vous", style: const TextStyle(fontSize: 20)),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(LucideIcons.filter, size: 16, color: Color(0xFF444444)),
                      label: const Text("Filtres", style: TextStyle(color: Color(0xFF444444), fontSize: 14)),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Feed List
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: demandes.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final d = demandes[index];
                    return _buildRequestCard(d);
                  },
                ),
                
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusToggle() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SangVieTypography.h2("Statut de don", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 4),
                SangVieTypography.small(
                  _isActive ? "Vous êtes visible pour les urgences" : "Vous ne recevrez pas de notifications",
                ),
              ],
            ),
          ),
          Switch(
            value: _isActive,
            onChanged: (val) => setState(() => _isActive = val),
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF1A7A3F),
            inactiveTrackColor: const Color(0xFFE0E0E0),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard(BloodRequest d) {
    return GestureDetector(
      onTap: () => _showRequestDetails(d),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE0E0E0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.sangVieRed.withOpacity(0.1),
                      child: Text(d.group, style: const TextStyle(color: AppColors.sangVieRed, fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(d.hospital, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Row(
                          children: [
                            const Icon(LucideIcons.mapPin, size: 12, color: Color(0xFF888888)),
                            const SizedBox(width: 4),
                            Text(d.distance, style: const TextStyle(color: Color(0xFF888888), fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                _buildBadge(d.urgency),
              ],
            ),
            const SizedBox(height: 12),
            SangVieTypography.body(d.description, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 12),
            const Divider(color: Color(0xFFE0E0E0)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Il y a 10 min", style: TextStyle(color: Color(0xFF888888), fontSize: 12)),
                SangVieButton(
                  label: "Répondre",
                  onPressed: () => _showRequestDetails(d),
                  height: 32,
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn().moveY(begin: 20, end: 0);
  }

  Widget _buildBadge(String urgency) {
    final color = urgency == 'critical' ? AppColors.sangVieRed : AppColors.warningOrange;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        urgency == 'critical' ? "Urgence vitale" : "Urgence modérée",
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _showRequestDetails(BloodRequest d) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildDetailModal(d),
    );
  }

  Widget _buildDetailModal(BloodRequest d) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: const Color(0xFFE0E0E0), borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 24),
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.sangVieRed.withOpacity(0.1),
            child: Text(d.group, style: const TextStyle(color: AppColors.sangVieRed, fontWeight: FontWeight.bold, fontSize: 32)),
          ),
          const SizedBox(height: 12),
          _buildBadge(d.urgency),
          const SizedBox(height: 8),
          SangVieTypography.h2(d.hospital, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(LucideIcons.mapPin, size: 14, color: Color(0xFF888888)),
              const SizedBox(width: 4),
              Text("Ouagadougou, Secteur 4 (${d.distance})", style: const TextStyle(color: Color(0xFF888888), fontSize: 14)),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFFF9F9F9), borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Description médicale", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 8),
                Text(d.description, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFFFF4E5), border: Border.all(color: const Color(0xFFD4720B).withOpacity(0.3)), borderRadius: BorderRadius.circular(12)),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(LucideIcons.checkCircle2, size: 20, color: Color(0xFFD4720B)),
                SizedBox(width: 12),
                Expanded(child: Text("Assurez-vous d'avoir mangé et d'être bien hydraté avant de vous rendre à l'hôpital.", style: TextStyle(color: Color(0xFFD4720B), fontSize: 12))),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(child: SangVieButton(label: "Fermer", onPressed: () => Navigator.pop(context), backgroundColor: AppColors.muted)),
              const SizedBox(width: 12),
              Expanded(child: SangVieButton(label: "Je peux donner", onPressed: () {})),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
