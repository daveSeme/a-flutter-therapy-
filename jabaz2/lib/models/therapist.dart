// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Therapist {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String specialization;
  final String rating;
  final String image;
  final String physicalAddress;

  Therapist({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.specialization,
    required this.rating,
    required this.image,
    required this.physicalAddress,
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
    String? physicalAddress,
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
      physicalAddress: physicalAddress ?? this.physicalAddress,
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
      'physicalAddress': physicalAddress,
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
      physicalAddress: map['physicalAddress'] as String,
    );
  }

  factory Therapist.fromSnapshot(DocumentSnapshot snapshot) {
    final therapist = snapshot.data() as Map<String, dynamic>;
    return Therapist(
      id: therapist['id'],
      firstName: therapist['firstName'],
      lastName: therapist['lastName'],
      phone: therapist['phone'],
      email: therapist['email'],
      specialization: therapist['specialization'],
      rating: therapist['rating'],
      image: therapist['image'],
      physicalAddress: therapist['physicalAddress'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Therapist.fromJson(String source) =>
      Therapist.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Therapist(id: $id, firstName: $firstName, lastName: $lastName, phone: $phone, email: $email, specialization: $specialization, rating: $rating, image: $image, physicalAddress: $physicalAddress)';
  }

  @override
  bool operator ==(covariant Therapist other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.phone == phone &&
        other.email == email &&
        other.specialization == specialization &&
        other.rating == rating &&
        other.image == image &&
        other.physicalAddress == physicalAddress;
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
        physicalAddress.hashCode;
  }
}
