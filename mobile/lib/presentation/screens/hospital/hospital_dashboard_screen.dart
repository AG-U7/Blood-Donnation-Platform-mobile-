import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sangvie/core/theme/app_colors.dart';
import 'package:sangvie/data/models/blood_request_model.dart';
import 'package:sangvie/data/repositories/blood_request_repository.dart';
import 'package:sangvie/presentation/widgets/hospital_layout.dart';
import 'package:sangvie/presentation/widgets/ui_components.dart';

class HospitalDashboardScreen extends StatefulWidget {
  const HospitalDashboardScreen({super.key});

  @override
  State<HospitalDashboardScreen> createState() => _HospitalDashboardScreenState();
}

class _HospitalDashboardScreenState extends State<HospitalDashboardScreen> {
  final BloodRequestRepository _repository = BloodRequestRepository();
  bool _isNewRequestModalOpen = false;

  @override
  Widget build(BuildContext context) {
    return HospitalLayout(
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                _buildStatsGrid(),
                const SizedBox(height: 40),
                _buildRecentRequestsTable(),
              ],
            ),
          ),
          
          // FAB (Tablette/Mobile uniquement)
          if (MediaQuery.of(context).size.width < 1024)
            Positioned(
              bottom: 20,
              right: 0,
              child: FloatingActionButton(
                onPressed: () => setState(() => _isNewRequestModalOpen = true),
                backgroundColor: AppColors.sangVieRed,
                child: const Icon(LucideIcons.plus, color: Colors.white),
              ),
            ),
            
          if (_isNewRequestModalOpen)
            _buildNewRequestModal(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SangVieTypography.h1("Tableau de bord", style: const TextStyle(fontSize: 32)),
        const SizedBox(height: 4),
        SangVieTypography.body("Bienvenue, CHU Yalgado Ouédraogo."),
      ],
    );
  }

  Widget _buildStatsGrid() {
    final stats = [
      {"label": "Demandes actives", "value": "3", "icon": LucideIcons.clock, "color": const Color(0xFFD4720B)},
      {"label": "Dons reçus (Ce mois)", "value": "145", "icon": LucideIcons.droplet, "color": const Color(0xFF1A7A3F)},
      {"label": "Taux de réponse", "value": "87%", "icon": LucideIcons.checkCircle, "color": AppColors.sangVieRed},
      {"label": "Total donneurs", "value": "1,204", "icon": LucideIcons.users, "color": const Color(0xFF111111)},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(8)),
                    child: Icon(s['icon'] as IconData, color: s['color'] as Color, size: 20),
                  ),
                  const Icon(LucideIcons.arrowUpRight, size: 14, color: AppColors.mutedForeground),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s['label'] as String, style: const TextStyle(color: Color(0xFF888888), fontSize: 12)),
                  Text(s['value'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRecentRequestsTable() {
    return FutureBuilder<List<BloodRequest>>(
      future: _repository.getRecentRequests(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final requests = snapshot.data!;

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SangVieTypography.h2("Dernières demandes", style: const TextStyle(fontSize: 18)),
                    TextButton(onPressed: () {}, child: const Text("Voir tout", style: TextStyle(color: AppColors.sangVieRed))),
                  ],
                ),
              ),
              const Divider(height: 1),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: requests.length,
                separatorBuilder: (context, index) => const Divider(height: 1, indent: 16, endIndent: 16),
                itemBuilder: (context, index) {
                  final r = requests[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.sangVieRed.withOpacity(0.1),
                      child: Text(r.group, style: const TextStyle(color: AppColors.sangVieRed, fontWeight: FontWeight.bold)),
                    ),
                    title: Row(
                      children: [
                        Text("${r.qty ?? 0} poches", style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        _buildStatusBadge(r.status ?? "active"),
                      ],
                    ),
                    subtitle: Text(r.date, style: const TextStyle(fontSize: 12, color: Color(0xFF888888))),
                    trailing: TextButton(onPressed: () {}, child: const Text("Détails", style: TextStyle(color: AppColors.sangVieRed))),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusBadge(String status) {
    final color = status == 'active' ? AppColors.warningOrange : const Color(0xFF1A7A3F);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
      child: Text(
        status == 'active' ? 'En cours' : 'Clôturée',
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildNewRequestModal() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () => setState(() => _isNewRequestModalOpen = false),
        child: Container(
          color: Colors.black.withOpacity(0.4),
          child: Center(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SangVieTypography.h2("Nouvelle demande"),
                    const SizedBox(height: 24),
                    const SangVieInput(label: "Groupe Sanguin", hint: "ex: O+"),
                    const SizedBox(height: 16),
                    const SangVieInput(label: "Quantité", hint: "en poches"),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(child: SangVieButton(label: "Annuler", onPressed: () => setState(() => _isNewRequestModalOpen = false), backgroundColor: AppColors.muted)),
                        const SizedBox(width: 12),
                        Expanded(child: SangVieButton(label: "Créer", onPressed: () => setState(() => _isNewRequestModalOpen = false))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
extension on BloodRequest {
  int? get qty => 1; // Simulation
}
