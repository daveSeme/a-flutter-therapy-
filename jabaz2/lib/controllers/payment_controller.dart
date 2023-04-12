import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/pay.dart';

class PaymentController {
  static Future pay(Pay pay) async {
    final result = await http.post(
        Uri.parse(
            "https://intense-mesa-19647.herokuapp.com/api/v1/payments/pay"),
        headers: {"Accept": "Application/json"},
        body: jsonEncode(pay.toMap()));

    var convertDataToJson = jsonDecode(result.body);

    if (kDebugMode) {
      print("RESPONSE===== $convertDataToJson");
    }
    return convertDataToJson;
  }
}
