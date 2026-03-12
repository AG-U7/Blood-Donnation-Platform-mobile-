import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sangvie/core/services/auth_service.dart';
import 'package:sangvie/core/services/language_service.dart';
import 'package:sangvie/core/theme/app_colors.dart';
import 'package:sangvie/presentation/widgets/public_layout.dart';
import 'package:sangvie/presentation/widgets/ui_components.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _donorNameController = TextEditingController();
  final TextEditingController _donorPhoneController = TextEditingController();
  final TextEditingController _donorPasswordController = TextEditingController();
  final TextEditingController _donorConfirmPasswordController = TextEditingController();
  
  String? _selectedBloodGroup;
  final List<String> _bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);
    final t = languageService.t;

    return PublicLayout(
      child: Container(
        color: const Color(0xFFF9F9F9),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 450),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0E0E0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SangVieTypography.h1(
                    t('auth.register.title'),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  SangVieTypography.body(
                    t('auth.register.subtitle'),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  
                  // Tabs
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      labelColor: AppColors.foreground,
                      unselectedLabelColor: AppColors.mutedForeground,
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'DM Sans'),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      tabs: [
                        Tab(text: t('auth.register.donorTab')),
                        Tab(text: t('auth.register.hospitalTab')),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  SizedBox(
                    height: 520, // Augmenté pour accueillir le nouveau champ
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildDonorForm(t, languageService),
                        _buildHospitalForm(t),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SangVieTypography.small(t('auth.register.already')),
                      TextButton(
                        onPressed: () => context.go('/login'),
                        child: Text(
                          t('auth.register.login'),
                          style: const TextStyle(
                            color: AppColors.sangVieRed,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDonorForm(String Function(String) t, LanguageService languageService) {
    return Column(
      children: [
        SangVieInput(
          label: t('auth.register.fullName'), 
          hint: "Votre nom complet",
          controller: _donorNameController,
        ),
        const SizedBox(height: 16),
        SangVieInput(
          label: t('auth.register.phone'), 
          hint: "+226 XX XX XX XX",
          controller: _donorPhoneController,
        ),
        const SizedBox(height: 16),
        SangVieDropdown<String>(
          label: t('auth.register.bloodGroup'),
          hint: "Sélectionnez votre groupe",
          value: _selectedBloodGroup,
          items: _bloodGroups.map((group) => DropdownMenuItem(
            value: group,
            child: Text(group),
          )).toList(),
          onChanged: (value) {
            setState(() {
              _selectedBloodGroup = value;
            });
          },
        ),
        const SizedBox(height: 16),
        SangVieInput(
          label: t('auth.register.password'), 
          hint: "Votre mot de passe", 
          obscureText: true,
          controller: _donorPasswordController,
        ),
        const SizedBox(height: 16),
        SangVieInput(
          label: t('auth.register.passwordConfirm'), 
          hint: "Confirmez votre mot de passe", 
          obscureText: true,
          controller: _donorConfirmPasswordController,
        ),
        const Spacer(),
        SangVieButton(
          label: t('auth.register.submit'), 
          onPressed: () async {
            final authService = Provider.of<AuthService>(context, listen: false);
            final success = await authService.register(
              name: _donorNameController.text,
              identifier: _donorPhoneController.text,
              password: _donorPasswordController.text,
              type: UserType.donor,
              bloodGroup: _selectedBloodGroup,
            );
            
            if (success && mounted) {
              context.go('/donor/home');
            }
          }, 
          isFullWidth: true,
        ),
      ],
    );
  }

  Widget _buildHospitalForm(String Function(String) t) {
    return Column(
      children: [
        SangVieInput(label: t('auth.register.hospitalName'), hint: "Nom de l'établissement"),
        const SizedBox(height: 16),
        SangVieInput(label: t('auth.register.hospitalId'), hint: "Numéro IFU / Identification"),
        const SizedBox(height: 16),
        SangVieInput(label: t('auth.register.hospitalEmail'), hint: "contact@hopital.bf"),
        const SizedBox(height: 16),
        SangVieInput(label: t('auth.register.password'), hint: "Votre mot de passe", obscureText: true),
        const Spacer(),
        SangVieButton(label: t('auth.register.submit'), onPressed: () {}, isFullWidth: true),
      ],
    );
  }
}
