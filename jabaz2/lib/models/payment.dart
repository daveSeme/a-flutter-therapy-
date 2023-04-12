// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Payment {
  final String id;
  final String amount;
  final String bookingId;
  final String responseCode;
  final String status;
  final String merchantRequestID;
  final String checkoutRequestID;
  final String mpesaReceiptNumber;
  final String transactionDate;
  final String phoneNumber;
  final String resultDesc;
  final String resultCode;
  final String userId;
  Payment({
    required this.id,
    required this.amount,
    required this.bookingId,
    required this.responseCode,
    required this.status,
    required this.merchantRequestID,
    required this.checkoutRequestID,
    required this.mpesaReceiptNumber,
    required this.transactionDate,
    required this.phoneNumber,
    required this.resultDesc,
    required this.resultCode,
    required this.userId,
  });

  Payment copyWith({
    String? id,
    String? amount,
    String? bookingId,
    String? responseCode,
    String? status,
    String? merchantRequestID,
    String? checkoutRequestID,
    String? mpesaReceiptNumber,
    String? transactionDate,
    String? phoneNumber,
    String? resultDesc,
    String? resultCode,
    String? userId,
  }) {
    return Payment(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      bookingId: bookingId ?? this.bookingId,
      responseCode: responseCode ?? this.responseCode,
      status: status ?? this.status,
      merchantRequestID: merchantRequestID ?? this.merchantRequestID,
      checkoutRequestID: checkoutRequestID ?? this.checkoutRequestID,
      mpesaReceiptNumber: mpesaReceiptNumber ?? this.mpesaReceiptNumber,
      transactionDate: transactionDate ?? this.transactionDate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      resultDesc: resultDesc ?? this.resultDesc,
      resultCode: resultCode ?? this.resultCode,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'bookingId': bookingId,
      'responseCode': responseCode,
      'status': status,
      'merchantRequestID': merchantRequestID,
      'checkoutRequestID': checkoutRequestID,
      'mpesaReceiptNumber': mpesaReceiptNumber,
      'transactionDate': transactionDate,
      'phoneNumber': phoneNumber,
      'resultDesc': resultDesc,
      'resultCode': resultCode,
      'userId': userId,
    };
  }

  factory Payment.fromMap(Map<dynamic, dynamic> map) {
    return Payment(
      id: map['Id'] as String,
      amount: map['Amount'] as String,
      bookingId: map['BookingId'] as String,
      responseCode: map['ResponseCode'] as String,
      status: map['Status'] as String,
      merchantRequestID: map['MerchantRequestID'] as String,
      checkoutRequestID: map['CheckoutRequestID'] as String,
      mpesaReceiptNumber: map['MpesaReceiptNumber'] as String,
      transactionDate: map['TransactionDate'] as String,
      phoneNumber: map['PhoneNumber'] as String,
      resultDesc: map['ResultDesc'] as String,
      resultCode: map['ResultCode'] as String,
      userId: map['UserId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Payment.fromJson(String source) =>
      Payment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Payment(id: $id, amount: $amount, bookingId: $bookingId, responseCode: $responseCode, status: $status, merchantRequestID: $merchantRequestID, checkoutRequestID: $checkoutRequestID, mpesaReceiptNumber: $mpesaReceiptNumber, transactionDate: $transactionDate, phoneNumber: $phoneNumber, resultDesc: $resultDesc, resultCode: $resultCode, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Payment &&
        other.id == id &&
        other.amount == amount &&
        other.bookingId == bookingId &&
        other.responseCode == responseCode &&
        other.status == status &&
        other.merchantRequestID == merchantRequestID &&
        other.checkoutRequestID == checkoutRequestID &&
        other.mpesaReceiptNumber == mpesaReceiptNumber &&
        other.transactionDate == transactionDate &&
        other.phoneNumber == phoneNumber &&
        other.resultDesc == resultDesc &&
        other.resultCode == resultCode &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        amount.hashCode ^
        bookingId.hashCode ^
        responseCode.hashCode ^
        status.hashCode ^
        merchantRequestID.hashCode ^
        checkoutRequestID.hashCode ^
        mpesaReceiptNumber.hashCode ^
        transactionDate.hashCode ^
        phoneNumber.hashCode ^
        resultDesc.hashCode ^
        resultCode.hashCode ^
        userId.hashCode;
  }
}
