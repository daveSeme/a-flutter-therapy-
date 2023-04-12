// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Pay {
  final String bookingId;
  final String userId;
  final String amount;
  final String phone;
  Pay({
    required this.bookingId,
    required this.userId,
    required this.amount,
    required this.phone,
  });

  Pay copyWith({
    String? bookingId,
    String? userId,
    String? amount,
    String? phone,
  }) {
    return Pay(
      bookingId: bookingId ?? this.bookingId,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'BookingID': bookingId,
      'UserId': userId,
      'Amount': amount,
      'PhoneNumber': phone,
    };
  }

  factory Pay.fromMap(Map<String, dynamic> map) {
    return Pay(
      bookingId: map['bookingId'] as String,
      userId: map['userId'] as String,
      amount: map['amount'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pay.fromJson(String source) => Pay.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pay(bookingId: $bookingId, userId: $userId, amount: $amount, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Pay &&
      other.bookingId == bookingId &&
      other.userId == userId &&
      other.amount == amount &&
      other.phone == phone;
  }

  @override
  int get hashCode {
    return bookingId.hashCode ^
      userId.hashCode ^
      amount.hashCode ^
      phone.hashCode;
  }
}
