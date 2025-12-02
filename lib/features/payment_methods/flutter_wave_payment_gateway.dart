
import 'package:all_payment_gateway/config/payment_config.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/core/TransactionCallBack.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/core/transaction_status.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:flutterwave_standard/models/TransactionError.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/requests/standard_request.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';
import 'package:flutterwave_standard/models/responses/standard_response.dart';
import 'package:flutterwave_standard/models/subaccount.dart';
import 'package:flutterwave_standard/utils.dart';
import 'package:flutterwave_standard/view/flutterwave_in_app_browser.dart';
import 'package:flutterwave_standard/view/flutterwave_style.dart';
import 'package:flutterwave_standard/view/standard_webview.dart';
import 'package:flutterwave_standard/view/standard_widget.dart';
import 'package:flutterwave_standard/view/view_utils.dart';
import 'package:uddoktapay/controllers/payment_controller.dart';
class FlutterWavePaymentGateway { 

FlutterWavePaymentGateway.interner();

Future<void> makePayment(BuildContext context) async {
   final Customer customer = Customer(
      name: "John Doe",
      phoneNumber: "0123456789",
      email: "ibarahim@example.com");

      final Flutterwave flutterwave=Flutterwave(
        
      
        publicKey: PaymentConfig.flutterWavePublicKey, 
        txRef: "TXREF${DateTime.now().millisecondsSinceEpoch}",
         amount:"200" , 
         customer: customer, 
         paymentOptions: "ussd, card, bank transfer", 
         customization: Customization(title: "Test Payment",) ,
        redirectUrl:  "https://flutterwave.com", 
         isTestMode: true,
          currency: "NGN"
          );
 
 final ChargeResponse response = await flutterwave.charge(context);
  
  if (response.success == true) {
    print("Payment Successful");
  } else {
    print("Payment Failed or Cancelled");
  }
  } 


}