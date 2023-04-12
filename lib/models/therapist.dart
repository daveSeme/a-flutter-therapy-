// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class Therapist {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String specialization;
  final String rating;
  final String image;
  final String physical_address;
  
  Therapist({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.specialization,
    required this.rating,
    required this.image,
    required this.physical_address,
  });

  

  Therapist copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? specialization,
    String? rating,
    String? image,
    String? physical_address,
  }) {
    return Therapist(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      specialization: specialization ?? this.specialization,
      rating: rating ?? this.rating,
      image: image ?? this.image,
      physical_address: physical_address ?? this.physical_address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'specialization': specialization,
      'rating': rating,
      'image': image,
      'physical_address': physical_address,
    };
  }

  factory Therapist.fromMap(Map<dynamic, dynamic> map) {
    return Therapist(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      specialization: map['specialization'] as String,
      rating: map['rating'] as String,
      image: map['image'] as String,
      physical_address: map['physical_address'] as String,
    );
  }

   factory Therapist.fromSnapshort(DataSnapshot snapshot) {
    return Therapist(
      id: snapshot.value['id'] as String,
      firstName: snapshot.value['firstName'] as String,
      lastName: snapshot.value['lastName'] as String,
      phone: snapshot.value['phone'] as String,
      email: snapshot.value['email'] as String,
      specialization: snapshot.value['specialization'] as String,
      rating: snapshot.value['rating'] as String,
      image: snapshot.value['image'] as String,
      physical_address: snapshot.value['physical_address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Therapist.fromJson(String source) => Therapist.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Therapist(id: $id, firstName: $firstName, lastName: $lastName, phone: $phone, email: $email, specialization: $specialization, rating: $rating, image: $image, physical_address: $physical_address)';
  }

  @override
  bool operator ==(covariant Therapist other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.phone == phone &&
      other.email == email &&
      other.specialization == specialization &&
      other.rating == rating &&
      other.image == image &&
      other.physical_address == physical_address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      phone.hashCode ^
      email.hashCode ^
      specialization.hashCode ^
      rating.hashCode ^
      image.hashCode ^
      physical_address.hashCode;
  }
}
