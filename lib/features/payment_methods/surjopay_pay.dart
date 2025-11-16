import 'package:flutter/material.dart';
import 'package:shurjopay/shurjopay.dart';
import 'package:shurjopay/models/config.dart';
import 'package:shurjopay/models/shurjopay_request_model.dart';
import 'package:shurjopay/models/shurjopay_response_model.dart';
import 'package:shurjopay/models/payment_verification_model.dart';

class SurjoPay {
  SurjoPay.internals();

  static final ShurjoPay _shurjoPay = ShurjoPay();

  Future<void> makePayment(BuildContext context, double amount) async {
    try {
      // Create shurjoPay configs
      ShurjopayConfigs shurjopayConfigs = ShurjopayConfigs(
        prefix: 'SP',
        userName: 'sp_sandbox',
        password: 'pyyk97hu&6u6',
        clientIP: '192.168.0.1',
      );

      // Create payment request model
      ShurjopayRequestModel shurjopayRequestModel = ShurjopayRequestModel(
        configs: shurjopayConfigs,
        currency: 'BDT',
        amount: amount,
        orderID: 'SP${DateTime.now().millisecondsSinceEpoch}',
        discountAmount: 0,
        discountPercentage: 0,
        customerName: 'Customer Name',
        customerPhoneNumber: '01700000000',
        customerEmail: 'customer@example.com',
        customerAddress: 'Customer Address',
        customerCity: 'Dhaka',
        customerPostcode: '1000',
        returnURL: 'https://www.sandbox.shurjopayment.com/return_url',
        cancelURL: 'https://www.sandbox.shurjopayment.com/cancel_url',
      );

      // Make payment
      ShurjopayResponseModel shurjopayResponseModel = await _shurjoPay.makePayment(
        context: context,
        shurjopayRequestModel: shurjopayRequestModel,
      );

      if (shurjopayResponseModel.status == true) {
        print('✅ SurjoPay Payment Initiated');
        
        // Verify payment
        try {
          ShurjopayVerificationModel verificationModel = await _shurjoPay.verifyPayment(
            orderID: shurjopayResponseModel.shurjopayOrderID!,
          );
          
          if (verificationModel.spCode == '1000') {
            print('✅ SurjoPay Payment Verified');
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Payment Successful! TX: ${verificationModel.bankTrxId ?? "N/A"}'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          } else {
            print('⚠️ SurjoPay Verification Failed: ${verificationModel.spMessage}');
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Verification Failed: ${verificationModel.spMessage ?? "Unknown"}'),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          }
        } catch (e) {
          print('❌ SurjoPay Verification Error: ${e.toString()}');
        }
      } else {
        print('❌ SurjoPay Payment Failed: ${shurjopayResponseModel.message}');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Payment Failed: ${shurjopayResponseModel.message ?? 'Unknown error'}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      print('🚨 SurjoPay Error: ${e.toString()}');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

//   void shurjoPay() async {
//   final shurjoPay = ShurjoPay();

//   final paymentResponse = await shurjoPay.makePayment(
//     context: Get.context!,
//     shurjopayRequestModel: ShurjopayRequestModel(
//       configs: ShurjopayConfigs(
//         prefix: 'NOK',
//         userName: 'sp_sandbox',
//         password: 'pyyk97hu&6u6',
//         clientIP: '127.0.0.1',
//       ),
//       currency: 'BDT',
//       amount: totalPrice,
//       orderID: 'test00255588',
//       customerName: 'Md Shirajul Islam',
//       customerPhoneNumber: '+8801700000000',
//       customerAddress: 'Dhaka, Bangladesh',
//       customerCity: 'Dhaka',
//       customerPostcode: '1000',
//       returnURL: 'url',
//       cancelURL: 'url',
//     ),
//   );

//   if (paymentResponse.status == true) {
//     try {
//       final verifyResponse = await shurjoPay.verifyPayment(
//           orderID: paymentResponse.shurjopayOrderID!);

//       if (verifyResponse.spCode == '1000') {
//         print(verifyResponse.bankTrxId);
//       } else {
//         print(verifyResponse.spMessage);
//       }

//       // if (verifyResponse.bankTrxId == null || verifyResponse.bankTrxId!.isEmpty || verifyResponse.bankTrxId == '') {
//       //
//       //   print('Something is wrong with your payment');
//       //
//       // }
//       // else {
//       //
//       //   print(verifyResponse.bankTrxId);
//       //   print(verifyResponse.message);
//       //
//       // }
//     } catch (e) {
//       print(e);
//     }
//   }
// }
}
