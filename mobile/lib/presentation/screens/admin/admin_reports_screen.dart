import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sangvie/core/theme/app_colors.dart';
import 'package:sangvie/presentation/widgets/admin_layout.dart';
import 'package:sangvie/presentation/widgets/ui_components.dart';

class AdminReportsScreen extends StatelessWidget {
  const AdminReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SangVieTypography.h1("Rapports", style: const TextStyle(fontSize: 24)),
                    const Text("Vue d'ensemble nationale", style: TextStyle(color: Color(0xFF888888), fontSize: 12)),
                  ],
                ),
                SangVieButton(label: "Exporter", onPressed: () {}, backgroundColor: AppColors.successGreen, height: 36),
              ],
            ),
            const SizedBox(height: 24),
            
            // Global KPIs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildGlobalKPI("Dons", "4,250", "+12%", AppColors.sangVieRed, LucideIcons.droplet),
                  const SizedBox(width: 12),
                  _buildGlobalKPI("Donneurs", "8,921", "+8%", AppColors.successGreen, LucideIcons.users),
                  const SizedBox(width: 12),
                  _buildGlobalKPI("Hôpitaux", "42", "+5%", Colors.orange, LucideIcons.building2),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Monthly Trend
            _buildSection("Évolution mensuelle", Column(
              children: [
                SizedBox(
                  height: 180,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildTrendBar("Oct", 0.7),
                      _buildTrendBar("Nov", 0.8),
                      _buildTrendBar("Déc", 0.6),
                      _buildTrendBar("Jan", 0.9),
                      _buildTrendBar("Fév", 0.85),
                      _buildTrendBar("Mar", 1.0),
                    ],
                  ),
                ),
              ],
            )),
            
            const SizedBox(height: 32),
            
            // Regional Distribution
            _buildSection("Distribution régionale", Column(
              children: [
                _buildRegionRow("Centre", 0.8, "672 dons", "+12%"),
                _buildRegionRow("Hauts-Bassins", 0.5, "298 dons", "+8%"),
                _buildRegionRow("Cascades", 0.2, "124 dons", "-3%"),
              ],
            )),
            
            const SizedBox(height: 32),
            
            // Detailed Table
            _buildSection("Détails par région", Container(
              decoration: BoxDecoration(border: Border.all(color: const Color(0xFFF0F0F0)), borderRadius: BorderRadius.circular(8)),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                },
                children: [
                  _buildTableHeader(),
                  _buildTableRow("Centre", "18", "672"),
                  _buildTableRow("Hauts", "8", "298"),
                  _buildTableRow("Cascades", "4", "124"),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildGlobalKPI(String label, String value, String growth, Color color, IconData icon) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withOpacity(0.8)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: Colors.white.withOpacity(0.8), size: 24),
              Text(growth, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: child,
        ),
      ],
    );
  }

  Widget _buildTrendBar(String month, double factor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 30,
          height: 120 * factor,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [AppColors.sangVieRed, Color(0xFFFF3333)], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(month, style: const TextStyle(color: Color(0xFF888888), fontSize: 10)),
      ],
    );
  }

  Widget _buildRegionRow(String name, double factor, String info, String growth) {
    bool isPositive = !growth.startsWith('-');
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Row(
                children: [
                  Text(info, style: const TextStyle(color: Color(0xFF888888), fontSize: 12)),
                  const SizedBox(width: 8),
                  Text(growth, style: TextStyle(color: isPositive ? AppColors.successGreen : AppColors.sangVieRed, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: factor,
            backgroundColor: const Color(0xFFF5F5F5),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.sangVieRed),
            minHeight: 6,
          ),
        ],
      ),
    );
  }

  TableRow _buildTableHeader() {
    return const TableRow(
      decoration: BoxDecoration(color: Color(0xFFF9F9F9)),
      children: [
        Padding(padding: EdgeInsets.all(12), child: Text("Région", style: TextStyle(color: Color(0xFF888888), fontSize: 10, fontWeight: FontWeight.bold))),
        Padding(padding: EdgeInsets.all(12), child: Text("Hôp.", style: TextStyle(color: Color(0xFF888888), fontSize: 10, fontWeight: FontWeight.bold))),
        Padding(padding: EdgeInsets.all(12), child: Text("Dons", style: TextStyle(color: Color(0xFF888888), fontSize: 10, fontWeight: FontWeight.bold))),
      ],
    );
  }

  TableRow _buildTableRow(String r, String h, String d) {
    return TableRow(
      children: [
        Padding(padding: EdgeInsets.all(12), child: Text(r, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
        Padding(padding: EdgeInsets.all(12), child: Text(h, style: const TextStyle(fontSize: 12))),
        Padding(padding: EdgeInsets.all(12), child: Text(d, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.sangVieRed))),
      ],
    );
  }
}
