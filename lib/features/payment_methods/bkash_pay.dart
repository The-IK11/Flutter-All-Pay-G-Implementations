import 'package:flutter/material.dart';
import 'package:bkash/bkash.dart';
import 'package:get/get.dart';


class BkashPay {


BkashPay.internals();

//for dummy payment
final bkash = Bkash(logResponse: true);

//For real payment

///final bkash = Bkash(bkashCredentials: BkashCredentials(username: "user name ", password: "password", appKey: "appKey", appSecret: "appSecret"));
double amount=0.0;
BkashPayment(BuildContext context)async{

  try {
final response=   await bkash.pay(context: context, amount: amount, merchantInvoiceNumber: "INV${DateTime.now().millisecondsSinceEpoch}");


print("Bkash Payment Response: $response");
print("Bkash TRX ID: ${response.trxId}"); 
print("Bkash Payment payment ID: ${response.paymentId}");



  }   on BkashFailure catch(e){


    print("Bkash Payment Failed: ${e.message}");
  }
}

}