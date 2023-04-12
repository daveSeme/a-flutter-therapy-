// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

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

   factory Address.fromSnapshort(DataSnapshot snapshot) {
    return Address(
      id: snapshot.value['id'] as String,
      latitude: snapshot.value['latitude'] as String,
      longitude: snapshot.value['longitude'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) => Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Address(id: $id, latitude: $latitude, longitude: $longitude)';

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.latitude == latitude &&
      other.longitude == longitude;
  }

  @override
  int get hashCode => id.hashCode ^ latitude.hashCode ^ longitude.hashCode;
}
