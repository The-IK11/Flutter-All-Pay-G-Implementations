
import 'dart:convert';

import 'package:all_payment_gateway/config/payment_config.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';

class SslCommerzPay { 

  SslCommerzPay.internals();

  /// SSLCommerz Payment
  Future<void> sslcommerz({required double amount}) async {
    // Generate unique transaction ID
    String uniqueTranId = "TRX${DateTime.now().millisecondsSinceEpoch}";
    
    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        multi_card_name: "visa,master,bkash",
        currency: SSLCurrencyType.BDT,
        product_category: "Digital Product",
        sdkType: PaymentConfig.sslCommerzIsSandbox ? SSLCSdkType.TESTBOX : SSLCSdkType.LIVE,
        store_id: PaymentConfig.sslCommerzStoreId,
        store_passwd: PaymentConfig.sslCommerzStorePassword,
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