import 'package:flutter/material.dart';
import 'package:flutter_nagad/flutter_nagad.dart';
import 'package:get/get.dart';
import 'package:nagad_payment_gateway/nagad_payment_gateway.dart';
import 'package:all_payment_gateway/config/payment_config.dart';

class NagadPay {
  NagadPay.internals();

  Nagad _getNagadInstance() {
    final merchantId = PaymentConfig.nagadMerchantId;
    final privateKey = PaymentConfig.nagadMerchantPrivateKey;
    final publicKey = PaymentConfig.nagadPgPublicKey;
    final isSandbox = PaymentConfig.nagadIsSandbox;
    
    // Debug logging
    print('🔍 Nagad Config Debug:');
    print('Merchant ID: $merchantId');
    print('Private Key Length: ${privateKey.length}');
    print('Public Key Length: ${publicKey.length}');
    print('Is Sandbox: $isSandbox');
    
    return Nagad(
      credentials: NagadCredentials(
        merchantID: merchantId,
        merchantPrivateKey: privateKey,
        pgPublicKey: publicKey,
        isSandbox: isSandbox,
      ),
    );
  }

  void setupMerchantInfo() {
    final nagad = _getNagadInstance();
    nagad.setAdditionalMerchantInfo({
      'serviceName': 'Brand',
      'serviceLogoURL':
          'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png',
      'additionalFieldNameEN': 'Type',
      'additionalFieldNameBN': 'টাইপ',
      'additionalFieldValue': 'Payment',
    });
  }

  Future<NagadResponse?> makePayment(BuildContext context, double amount) async {
    final nagad = _getNagadInstance();
    // Generating a unique order ID
    String orderId = 'order${DateTime.now().millisecondsSinceEpoch}';

    try {
      // Initiating a regular payment
      NagadResponse nagadResponse = await nagad.regularPayment(
        context,
        amount: amount,
        orderId: orderId,
      );

      return nagadResponse;
    } catch (e) {
      // Handling errors
      print('Nagad Payment Failed: ${e.toString()}');
      return null;
    }
  }
}
