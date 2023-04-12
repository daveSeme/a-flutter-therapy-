// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  final String id;
  final String latitude;
  final String longitude;
  Address({
    required this.id,
    required this.latitude,
    required this.longitude,
  });

  Address copyWith({
    String? id,
    String? latitude,
    String? longitude,
  }) {
    return Address(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Address.fromMap(Map<dynamic, dynamic> map) {
    return Address(
      id: map['id'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
    );
  }

  factory Address.fromSnapshot(DocumentSnapshot snapshot) {
    final address = snapshot.data() as Map<String, dynamic>;
    return Address(
        id: address['id'],
        latitude: address['latitude'],
        longitude: address['longitude']);
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Address(id: $id, latitude: $latitude, longitude: $longitude)';

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode => id.hashCode ^ latitude.hashCode ^ longitude.hashCode;
}
