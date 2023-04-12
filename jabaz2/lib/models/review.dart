// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:jabaz2/models/booking.dart';



class Review {
  final String message;
  final String id;
  final Booking booking;
  Review({
    required this.message,
    required this.id,
    required this.booking,
  });
  
  

  Review copyWith({
    String? message,
    String? id,
    Booking? booking,
  }) {
    return Review(
      message: message ?? this.message,
      id: id ?? this.id,
      booking: booking ?? this.booking,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'id': id,
      'booking': booking.toMap(),
    };
  }

  factory Review.fromMap(Map<dynamic, dynamic> map) {
    return Review(
      message: map['message'] as String,
      id: map['id'] as String,
      booking: Booking.fromMap(map['booking'] as Map<dynamic,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Review(message: $message, id: $id, booking: $booking)';

  @override
  bool operator ==(covariant Review other) {
    if (identical(this, other)) return true;
  
    return 
      other.message == message &&
      other.id == id &&
      other.booking == booking;
  }

  @override
  int get hashCode => message.hashCode ^ id.hashCode ^ booking.hashCode;
}
