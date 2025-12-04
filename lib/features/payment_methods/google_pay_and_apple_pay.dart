import 'dart:io';

import 'package:all_payment_gateway/config/pay_payment_config.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
class GooglePayAndApplePay {

  GooglePayAndApplePay.integerals();

    final List<PaymentItem> _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '10.00', // Change dynamically if needed
      status: PaymentItemStatus.final_price,
    ),
  ];

 Widget getPlatformButton({
    required void Function(Map<String, dynamic> onPaymentResult) onPaymentResult,
    EdgeInsets margin = const EdgeInsets.only(top: 15.0),
  }) {
    if (Platform.isIOS) {
      // Load PaymentConfiguration asynchronously and build ApplePayButton
      return FutureBuilder<PaymentConfiguration>(
        future: PaymentConfiguration.fromAsset('assets/google_and_apple_pay/apple_pay.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: const Text('Failed to load Apple Pay configuration'),
            );
          }
          return ApplePayButton(
            paymentConfiguration: snapshot.data!,
            paymentItems: _paymentItems,
            style: ApplePayButtonStyle.black,
            type: ApplePayButtonType.buy,
            margin: margin,
            onPaymentResult: onPaymentResult,
            loadingIndicator: const CircularProgressIndicator(),
          );
        },
      );
    } else if (Platform.isAndroid) {
      // Load PaymentConfiguration asynchronously and build GooglePayButton
      return FutureBuilder<PaymentConfiguration>(
        future: PaymentConfiguration.fromAsset('assets/google_and_apple_pay/google_pay.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: const Text('Failed to load Google Pay configuration'),
            );
          }
          return GooglePayButton(
            paymentConfiguration: snapshot.data!,
            paymentItems: _paymentItems,
            type: GooglePayButtonType.pay,
            margin: margin,
            onPaymentResult: onPaymentResult,
            loadingIndicator: const CircularProgressIndicator(),
          );
        },
      );
    } else {
      // Unsupported platform
      return Container(
        padding: const EdgeInsets.all(16),
        child: const Text("Payment not supported on this platform"),
      );
    }
  }


}


class PayPage extends StatefulWidget {
  const PayPage({super.key});

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  String os = Platform.operatingSystem;

  var applePayButton = ApplePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
    paymentItems: const [
      PaymentItem(
        label: 'Item A',
        amount: '0.01',
        status: PaymentItemStatus.final_price,
      ),
      PaymentItem(
        label: 'Item B',
        amount: '0.01',
        status: PaymentItemStatus.final_price,
      ),
      PaymentItem(
        label: 'Total',
        amount: '0.02',
        status: PaymentItemStatus.final_price,
      )
    ],
    style: ApplePayButtonStyle.black,
    width: double.infinity,
    height: 50,
    type: ApplePayButtonType.buy,
    margin: const EdgeInsets.only(top: 15.0),
    onPaymentResult: (result) => debugPrint('Payment Result $result'),
    loadingIndicator: const Center(
      child: CircularProgressIndicator(),
    ),
  );

  var googlePayButton = GooglePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
    paymentItems: const [
      PaymentItem(
        label: 'Total',
        amount: '0.01',
        status: PaymentItemStatus.final_price,
      )
    ],
    type: GooglePayButtonType.pay,
    margin: const EdgeInsets.only(top: 15.0),
    onPaymentResult: (result) => debugPrint('Payment Result $result'),
    loadingIndicator: const Center(
      child: CircularProgressIndicator(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(child: Platform.isIOS ? applePayButton : googlePayButton),
      ),
    );
  }
}