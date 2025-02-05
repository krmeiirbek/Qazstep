import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../utils/formatters/formatter.dart';

class UserModel {
  final String? id;
  String iin;
  String password;
  String point;

  UserModel({
    this.id,
    required this.iin,
    required this.password,
    required this.point,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "iin": iin,
      "password": password,
      "point": point,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      iin: json['iin'] as String? ?? '',
      password: json['password'] as String? ?? '',
      point: json['point'] as String? ?? '',
    );
  }

  static UserModel empty() => UserModel(
        id: '',
        iin: '',
        password: '',
        point: '',
      );

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        iin: data['iin'] ?? '',
        password: data['password'] ?? '',
        point: data['point'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }

  UserModel copyWith({
    String? id,
    String? iin,
    String? password,
    String? point,
  }) =>
      UserModel(
        id: id ?? this.id,
        iin: iin ?? this.iin,
        password: password ?? this.password,
        point: point ?? this.point,
      );
}
