import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sangvie/core/theme/app_colors.dart';
import 'package:sangvie/presentation/widgets/hospital_layout.dart';
import 'package:sangvie/presentation/widgets/ui_components.dart';

class HospitalStatsScreen extends StatelessWidget {
  const HospitalStatsScreen({super.key});

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
                SangVieTypography.h1("Statistiques", style: const TextStyle(fontSize: 24)),
                _buildDateSelector(),
              ],
            ),
            const SizedBox(height: 24),
            
            // KPI Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildKPICard("Demandes", "48", "+12%", LucideIcons.activity),
                _buildKPICard("Donneurs", "156", "+8%", LucideIcons.users),
                _buildKPICard("Poches", "342", "+15%", LucideIcons.droplet),
                _buildKPICard("Réponse", "87%", "+3%", LucideIcons.trendingUp),
              ],
            ),
            
            const SizedBox(height: 32),
            _buildChartSection(),
            
            const SizedBox(height: 32),
            _buildBloodGroupsSection(),
            
            const SizedBox(height: 32),
            _buildRecentActivitySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildKPICard(String label, String value, String change, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: AppColors.sangVieRed, size: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: AppColors.successGreen.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                child: Text(change, style: const TextStyle(color: AppColors.successGreen, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text(label, style: const TextStyle(color: Color(0xFF888888), fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Évolution mensuelle", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 24),
          SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar("Jan", 0.6),
                _buildBar("Fév", 0.8),
                _buildBar("Mar", 1.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String month, double heightFactor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 40,
          height: 100 * heightFactor,
          decoration: const BoxDecoration(
            color: AppColors.sangVieRed,
            borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
          ),
        ),
        const SizedBox(height: 8),
        Text(month, style: const TextStyle(color: Color(0xFF888888), fontSize: 12)),
      ],
    );
  }

  Widget _buildBloodGroupsSection() {
    final groups = [
      {'label': 'O+', 'pct': 0.26, 'count': 89},
      {'label': 'A+', 'pct': 0.21, 'count': 72},
      {'label': 'B+', 'pct': 0.17, 'count': 58},
    ];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Répartition par groupe", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 20),
          ...groups.map((g) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(g['label'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text("${g['count']} (${((g['pct'] as double) * 100).toInt()}%)", style: const TextStyle(color: Color(0xFF888888), fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: g['pct'] as double,
                      backgroundColor: const Color(0xFFF5F5F5),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.sangVieRed),
                      minHeight: 6,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildRecentActivitySection() {
    final activities = [
      {'title': 'Nouvelle demande', 'detail': 'O+ - 3 poches', 'time': '5 min'},
      {'title': 'Donneur confirmé', 'detail': 'Jean Dupont - A+', 'time': '15 min'},
    ];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Activité récente", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          ...activities.map((a) => Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(a['title']!, style: const TextStyle(fontWeight: FontWeight.w600)),
                        Text(a['detail']!, style: const TextStyle(color: Color(0xFF888888), fontSize: 12)),
                      ],
                    ),
                    Text(a['time']!, style: const TextStyle(color: Color(0xFF888888), fontSize: 12)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          Icon(LucideIcons.calendar, size: 14, color: Color(0xFF444444)),
          SizedBox(width: 8),
          Text("Ce mois", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
