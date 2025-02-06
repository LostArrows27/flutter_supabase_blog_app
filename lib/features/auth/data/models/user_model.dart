import 'package:flutter_supabase/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.name, required super.email});

  factory UserModel.fromJSON(Map<String, dynamic> mapData) {
    return UserModel(
        id: mapData['id'] ?? '',
        name: mapData['name'] ?? '',
        email: mapData['email'] ?? '');
  }
}
