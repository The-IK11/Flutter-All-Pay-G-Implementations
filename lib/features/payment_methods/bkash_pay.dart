import 'package:flutter/material.dart';
import 'package:bkash/bkash.dart';
import 'package:get/get.dart';
import 'package:all_payment_gateway/config/payment_config.dart';

class BkashPay {
  BkashPay.internals();

  // Using credentials from config
  final bkash = Bkash(
    logResponse: true,
    bkashCredentials: BkashCredentials(
      username: PaymentConfig.bkashUsername,
      password: PaymentConfig.bkashPassword,
      appKey: PaymentConfig.bkashAppKey,
      appSecret: PaymentConfig.bkashAppSecret,
      isSandbox: PaymentConfig.bkashIsSandbox,
    ),
  );

  double amount = 1000.0;

  Future<void> BkashPayment(BuildContext context) async {
    try {
      final response = await bkash.pay(
        context: context,
        amount: amount,
        merchantInvoiceNumber: "INV${DateTime.now().millisecondsSinceEpoch}",
      );

      print("Bkash Payment Response: $response");
      print("Bkash TRX ID: ${response.trxId}");
      print("Bkash Payment payment ID: ${response.paymentId}");
    } on BkashFailure catch (e) {
      print("Bkash Payment Failed: ${e.message}");
    }
  }
}