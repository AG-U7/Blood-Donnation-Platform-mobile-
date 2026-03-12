import 'package:sangvie/core/services/auth_service.dart';

class User {
  final String id;
  final String name;
  final UserType type;
  final String? phone;
  final String? email;
  final String? bloodType;

  User({
    required this.id,
    required this.name,
    required this.type,
    this.phone,
    this.email,
    this.bloodType,
  });

  factory User.fromMock(String id, Map<String, dynamic> data) {
    return User(
      id: id,
      name: id.contains('@') ? id.split('@')[0].toUpperCase() : 'Donneur',
      type: data['type'],
      email: id.contains('@') ? id : null,
      phone: id.startsWith('+') ? id : null,
      bloodType: data['type'] == UserType.donor ? 'O+' : null,
    );
  }
}
