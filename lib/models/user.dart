// ignore_for_file: public_member_api_docs, sort_constructors_first, import_of_legacy_library_into_null_safe
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class Account {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String role;
  final String image;
  Account({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.role,
    required this.image,
  });

  Account copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? role,
    String? image,
  }) {
    return Account(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      role: role ?? this.role,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'role': role,
      'image': image,
    };
  }

  factory Account.fromMap(Map<dynamic, dynamic> map) {
    return Account(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      role: map['role'] as String,
      image: map['image'] as String,
    );
  }

  factory Account.fromSnapshot(DataSnapshot snapshot) {
    return Account(
      id: snapshot.value['id'] as String,
      firstName: snapshot.value['firstName'] as String,
      lastName: snapshot.value['lastName'] as String,
      phone: snapshot.value['phone'] as String,
      email: snapshot.value['email'] as String,
      role: snapshot.value['role'] as String,
      image: snapshot.value['image'] as String,
    );
  }

  

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) => Account.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Account(id: $id, firstName: $firstName, lastName: $lastName, phone: $phone, email: $email, role: $role, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Account &&
      other.id == id &&
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.phone == phone &&
      other.email == email &&
      other.role == role &&
      other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      phone.hashCode ^
      email.hashCode ^
      role.hashCode ^
      image.hashCode;
  }
}
