import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddoktapay/uddoktapay.dart';  
import 'package:uddoktapay/models/customer_model.dart';
import 'package:uddoktapay/models/request_response.dart';
import 'package:uddoktapay/models/credentials.dart';


class UddoktaPayPayment {
  UddoktaPayPayment.internals();
  //Took APi key and secret from uddoktapay site for testing [https://uddoktapay.readme.io/reference/api-information]

  Future<void> makePayment(double amount, BuildContext context) async {
    try {
      final paymentResponse = await UddoktaPay.createPayment(
        context: context, 
  
        customer: CustomerDetails(
          fullName: "Md. Ibrahim Khalil", 
          email: "ibrahim@example.com"
        ), 

        //For production use your own credentials additionally here
  
   /**    credentials: UddoktapayCredentials(  
apiKey: 'api_key',  
panelURL: 'https://pay.domain.com',  
redirectURL: 'domain.com', 
),  
*/  
        amount: amount.toString()
      );
      
      // Check payment status from response
      if (paymentResponse.status != null) {
        print('Payment Status: ${paymentResponse.status}');
        
        if (paymentResponse.status == ResponseStatus.completed) {
          print('✅ Payment completed');
          print('Transaction ID: ${paymentResponse.transactionId}');
          print('Invoice ID: ${paymentResponse.invoiceId}');
          print('Amount: ${paymentResponse.amount}');
          print('Fee: ${paymentResponse.fee}');
          if (paymentResponse.senderNumber != null) {
            print('Sender Number: ${paymentResponse.senderNumber}');
          }
          if (paymentResponse.paymentMethod != null) {
            print('Payment Method: ${paymentResponse.paymentMethod}');
          }
        } else if (paymentResponse.status == ResponseStatus.canceled) {
          print('❌ Payment canceled');
        } else if (paymentResponse.status == ResponseStatus.pending) {
          print('⏳ Payment pending');
          print('Invoice ID: ${paymentResponse.invoiceId}');
        }
      } else {
        print('❌ No status returned from payment');
      }
    } catch (e) {
      print('❌ UddoktaPay Error: $e');
    }
  }
}