
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';

class SslCommerzPay { 

  SslCommerzPay.internals();

  /// SSLCommerz Payment
  Future<void> sslcommerz({required double amount}) async {
    // Load credentials from .env
    final String storeId = dotenv.env['SSLCOMMERZ_STORE_ID'] ?? 'testbox';
    final String storePassword = dotenv.env['SSLCOMMERZ_STORE_PASSWORD'] ?? 'qwerty';
    final bool isSandbox = dotenv.env['SSLCOMMERZ_IS_SANDBOX'] == 'true';
    
    // Generate unique transaction ID
    String uniqueTranId = "TRX${DateTime.now().millisecondsSinceEpoch}";
    
    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        multi_card_name: "visa,master,bkash",
        currency: SSLCurrencyType.BDT,
        product_category: "Digital Product",
        sdkType: isSandbox ? SSLCSdkType.TESTBOX : SSLCSdkType.LIVE,
        store_id: storeId,
        store_passwd: storePassword,
        total_amount: amount,
        tran_id: uniqueTranId,
      ),
    );

    try {
      final response = await sslcommerz.payNow();

      if (response.status == 'VALID') {
        print('✅ Payment completed successfully!');
        print('Transaction ID: ${response.tranId}');
        print('Transaction Date: ${response.tranDate}');
        print('Amount: ${response.amount}');
        print('Card Type: ${response.cardType}');
        print('Full Response: ${jsonEncode(response.toJson())}');
      } else if (response.status == 'FAILED') {
        print('❌ Payment failed');
        print('Status: ${response.status}');
      } else if (response.status == 'CANCELLED') {
        print('🚫 Payment cancelled by user');
      } else {
        print('⚠️ Payment status: ${response.status}');
      }
    } catch (e) {
      print('❌ SSLCommerz Error: $e');
    }
  }
}