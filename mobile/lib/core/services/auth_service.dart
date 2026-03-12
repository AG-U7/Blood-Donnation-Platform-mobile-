import 'package:flutter/material.dart';

enum UserType { donor, hospital, admin }

class AuthService extends ChangeNotifier {
  UserType? _currentUserType;
  UserType? get currentUserType => _currentUserType;

  // Mock database identique au web
  static const Map<String, Map<String, dynamic>> mockUsers = {
    // Donneurs
    "+22670123456": {"type": UserType.donor, "password": "donor123"},
    "+22675234567": {"type": UserType.donor, "password": "donor123"},
    // Hôpitaux
    "contact@chu-yo.bf": {"type": UserType.hospital, "password": "hospital123"},
    "contact@sandof.bf": {"type": UserType.hospital, "password": "hospital123"},
    // Admin
    "admin@sangvie.bf": {"type": UserType.admin, "password": "admin123"},
  };

  UserType? detectAccountType(String id) {
    if (mockUsers.containsKey(id)) {
      return mockUsers[id]!["type"] as UserType;
    }
    
    if (id.startsWith("+") || RegExp(r'^\d+$').hasMatch(id)) {
      return UserType.donor;
    } else if (id.contains("@")) {
      if (id.contains("admin")) {
        return UserType.admin;
      }
      return UserType.hospital;
    }
    return null;
  }

  Future<bool> login(String id, String password) async {
    // Simulation délai réseau
    await Future.delayed(const Duration(milliseconds: 500));
    
    final type = detectAccountType(id);
    if (type != null) {
      _currentUserType = type;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _currentUserType = null;
    notifyListeners();
  }
}
