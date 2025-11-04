import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_nagad/flutter_nagad.dart';
import 'package:get/get.dart';
import 'package:nagad_payment_gateway/nagad_payment_gateway.dart';

class NagadPay {
  NagadPay.internals();

  Nagad _getNagadInstance() {
    return Nagad(
      credentials: NagadCredentials(
        merchantID: dotenv.env['NAGAD_MERCHANT_ID'] ?? '683002007104225',
        merchantPrivateKey: dotenv.env['NAGAD_MERCHANT_PRIVATE_KEY'] ?? '',
        pgPublicKey: dotenv.env['NAGAD_PG_PUBLIC_KEY'] ?? '',
        isSandbox: dotenv.env['NAGAD_IS_SANDBOX'] == 'true',
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
