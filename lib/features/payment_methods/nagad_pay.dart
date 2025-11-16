import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nagad_payment_gateway/nagad_payment_gateway.dart';
import 'package:nagad_payment_gateway/src/credentials.dart';
import 'package:nagad_payment_gateway/src/api_resposne.dart';
import 'package:nagad_payment_gateway/src/status_model.dart';

class NagadPay {
  NagadPay.internals();
  
   //without sandbox credentials you cannot test Nagad payment
  //To get Nagad sandbox credentials, you must first register a mobile number for sandbox testing by contacting your Nagad account manager. 
  Nagad nagad= Nagad(
        credentials: Credentials (
            merchantID: '', // Provide the merchantID
            merchantPrivateKey: '', // Provide the merchantPrivateKey
            pgPublicKey: '', // Provide the pgPublicKey
            isSandbox: true // set false for production
            ));
 
        
  Future<void> makePayment(BuildContext context, int amount) async {

    ///IF needed, you can set additional merchant info like below
    /** 
    nagad.setAdditionalMerchantInfo({
            'serviceName': 'Brand',
      'serviceLogoURL':
          'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png',
      'additionalFieldNameEN': 'Type',
      'additionalFieldNameBN': 'টাইপ',
      'additionalFieldValue': 'Payment',
    }  );
    */
    try {
      print('🔍 Starting Nagad Payment for amount: $amount');
      
    
      // Generate unique order ID
     // String orderId = 'nagad${DateTime.now().millisecondsSinceEpoch}';

       final nagadResponse = await nagad.pay(
        context,
        amount: amount,
       
      );

       final status = StatusAPIResponse.fromJson(nagadResponse.toJson()).status;

      if (status == 'SUCCESS') {
        print('✅ Nagad Payment Successful: ${nagadResponse.toJson()}');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Nagad Payment Successful!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else if (status == 'FAILED') { // This check should be here, not inside the SUCCESS block
        print('❌ Nagad Payment Failed: ${nagadResponse.toJson()}');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Payment Failed: ${nagadResponse.toJson()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else if (status == 'PENDING') { // This check should also be here
        print('⏳ Nagad Payment Pending: ${nagadResponse.toJson()}');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Nagad Payment Pending!'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }
       

      
    } catch (e) {
      print('❌ Nagad Payment Error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
    
  