// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import 'package:thearapy_app/models/session.dart';
import 'package:thearapy_app/models/therapist.dart';
import 'package:thearapy_app/models/user.dart';

class Booking {
  final String id;
  final Account user;
  final Therapist therapist;
  final Session session;
  final String description;
  final String paymentStatus;
  final String physical;
  Booking({
    required this.id,
    required this.user,
    required this.therapist,
    required this.session,
    required this.description,
    required this.paymentStatus,
    required this.physical,
  });
  
  

  Booking copyWith({
    String? id,
    Account? user,
    Therapist? therapist,
    Session? session,
    String? description,
    String? paymentStatus,
    String? physical,
  }) {
    return Booking(
      id: id ?? this.id,
      user: user ?? this.user,
      therapist: therapist ?? this.therapist,
      session: session ?? this.session,
      description: description ?? this.description,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      physical: physical ?? this.physical,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user.toMap(),
      'therapist': therapist.toMap(),
      'session': session.toMap(),
      'description': description,
      'PaymentStatus': paymentStatus,
      'physical': physical,
    };
  }

  factory Booking.fromMap(Map<dynamic, dynamic> map) {
    return Booking(
      id: map['id'] as String,
      user: Account.fromMap(map['user'] as Map<dynamic,dynamic>),
      therapist: Therapist.fromMap(map['therapist'] as Map<dynamic,dynamic>),
      session: Session.fromMap(map['session'] as Map<dynamic,dynamic>),
      description: map['description'] as String,
      paymentStatus: map['PaymentStatus'] as String,
      physical: map['physical'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) => Booking.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Booking(id: $id, user: $user, therapist: $therapist, session: $session, description: $description, paymentStatus: $paymentStatus, physical: $physical)';
  }

  @override
  bool operator ==(covariant Booking other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.user == user &&
      other.therapist == therapist &&
      other.session == session &&
      other.description == description &&
      other.paymentStatus == paymentStatus &&
      other.physical == physical;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      user.hashCode ^
      therapist.hashCode ^
      session.hashCode ^
      description.hashCode ^
      paymentStatus.hashCode ^
      physical.hashCode;
  }
}
