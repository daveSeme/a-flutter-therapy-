// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class Session {
  
  final String id;
  final String specialistId;
  final String from;
  final String to;
  final String day;
  final String status;
  final String amount;
  Session({
    required this.id,
    required this.specialistId,
    required this.from,
    required this.to,
    required this.day,
    required this.status,
    required this.amount,
  });

  Session copyWith({
    String? id,
    String? specialistId,
    String? from,
    String? to,
    String? day,
    String? status,
    String? amount,
  }) {
    return Session(
      id: id ?? this.id,
      specialistId: specialistId ?? this.specialistId,
      from: from ?? this.from,
      to: to ?? this.to,
      day: day ?? this.day,
      status: status ?? this.status,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'specialistId': specialistId,
      'from': from,
      'to': to,
      'day': day,
      'status': status,
      'amount': amount,
    };
  }

  factory Session.fromMap(Map<dynamic, dynamic> map) {
    return Session(
      id: map['id'] as String,
      specialistId: map['specialistId'] as String,
      from: map['from'] as String,
      to: map['to'] as String,
      day: map['day'] as String,
      status: map['status'] as String,
      amount: map['amount'] as String,
    );
  }

  factory Session.fromSnapshort(DataSnapshot snapshot) {
    return Session(
      id: snapshot.value['id'] as String,
      specialistId: snapshot.value['specialistId'] as String,
      from: snapshot.value['from'] as String,
      to: snapshot.value['to'] as String,
      day: snapshot.value['day'] as String,
      status: snapshot.value['status'] as String,
      amount: snapshot.value['amount'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Session.fromJson(String source) => Session.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Session(id: $id, specialistId: $specialistId, from: $from, to: $to, day: $day, status: $status, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Session &&
      other.id == id &&
      other.specialistId == specialistId &&
      other.from == from &&
      other.to == to &&
      other.day == day &&
      other.status == status &&
      other.amount == amount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      specialistId.hashCode ^
      from.hashCode ^
      to.hashCode ^
      day.hashCode ^
      status.hashCode ^
      amount.hashCode;
  }
}

