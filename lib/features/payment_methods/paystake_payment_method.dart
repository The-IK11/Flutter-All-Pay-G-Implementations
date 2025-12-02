
import 'package:all_payment_gateway/config/payment_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack_plus/flutter_paystack_plus.dart';
class PayStackPayment {
  PayStackPayment.internal();

  Future<void> makePayment(BuildContext context) async {
  
  try {
                 await FlutterPaystackPlus.openPaystackPopup(
                        publicKey: PaymentConfig.payStackPublicKey,
                        context: context,
                        secretKey: PaymentConfig.payStackSecretKey,
                        currency: 'NGN',
                        customerEmail: "ibrahim@example.com",
                        amount: (2* 100).toString(),
                        reference: "PS${DateTime.now().millisecondsSinceEpoch}",
                        callBackUrl: "[GET IT FROM YOUR PAYSTACK DASHBOARD]",
                        onClosed: () {
                          debugPrint('Could\'nt finish payment');
                        },
                        onSuccess: () {
                          debugPrint('Payment successful');
                        });
                  } catch (e) {
                    debugPrint(e.toString());
                  }
  }}