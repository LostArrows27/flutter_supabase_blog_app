import 'package:flutter_supabase/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.name, required super.email});

  factory UserModel.fromJSON(Map<String, dynamic> mapData) {
    return UserModel(
        id: mapData['id'] ?? '',
        name: mapData['name'] ?? '',
        email: mapData['email'] ?? '');
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
