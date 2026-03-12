import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sangvie/core/services/auth_service.dart';
import 'package:sangvie/core/services/language_service.dart';
import 'package:sangvie/core/theme/app_colors.dart';
import 'package:sangvie/presentation/widgets/public_layout.dart';
import 'package:sangvie/presentation/widgets/ui_components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _error = "";

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    final t = languageService.t;

    Future<void> _handleLogin() async {
      setState(() => _error = "");
      final identifier = _identifierController.text;
      final password = _passwordController.text;

      if (identifier.isEmpty || password.isEmpty) {
        setState(() => _error = "Veuillez remplir tous les champs");
        return;
      }

      final success = await authService.login(identifier, password);
      if (success) {
        final type = authService.currentUserType;
        if (type == UserType.admin) {
          context.go('/admin/dashboard');
        } else if (type == UserType.hospital) {
          context.go('/hospital/dashboard');
        } else {
          context.go('/donor/feed');
        }
      } else {
        setState(() => _error = "Identifiant invalide");
      }
    }

    return PublicLayout(
      child: Container(
        color: const Color(0xFFF9F9F9),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
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
                    t('auth.login.title'),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  SangVieTypography.body(
                    t('auth.login.subtitle'),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  
                  SangVieInput(
                    label: t('auth.login.identifier'),
                    hint: "contact@hopital.com ou +226 XX XX XX XX",
                    controller: _identifierController,
                    errorText: _error.isNotEmpty ? _error : null,
                  ),
                  const SizedBox(height: 16),
                  
                  SangVieInput(
                    label: t('auth.login.password'),
                    hint: "Votre mot de passe",
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.push('/forgot-password'),
                      child: Text(
                        t('auth.login.forgot'),
                        style: const TextStyle(
                          color: AppColors.sangVieRed,
                          fontFamily: 'DM Sans',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  SangVieButton(
                    label: t('auth.login.submit'),
                    onPressed: _handleLogin,
                    height: 48,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SangVieTypography.small(t('auth.login.noAccount')),
                      TextButton(
                        onPressed: () => context.push('/register'),
                        child: Text(
                          t('auth.login.createAccount'),
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
}
