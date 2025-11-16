// import 'package:flutter/material.dart';
// import 'package:flutter_nagad/flutter_nagad.dart';
// import 'package:get/get.dart';

// class NagadPay {
//   NagadPay.internals();

//   Future<void> makePayment(BuildContext context, double amount) async {
//     try {
//       print('🔍 Starting Nagad Payment for amount: $amount');
      
//       // Use FlutterNagad with simplified approach
//       final flutterNagad = FlutterNagad.getInstance();
      
//       // Generate unique order ID
//       String orderId = 'nagad${DateTime.now().millisecondsSinceEpoch}';
      
//       flutterNagad
//           .getPaymentGateway(
//             paymentUrl: "https://sandbox-nagad.com/payment",  // Sandbox URL
//             orderId: orderId,
//             amount: amount,
//           )
//           .then((response) {
//         print('✅ Nagad Payment Success: $response');
//         if (context.mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Nagad Payment Successful!'),
//               backgroundColor: Colors.green,
//             ),
//           );
//         }
//       }).catchError((error) {
//         print('❌ Nagad Payment Failed: ${error.toString()}');
//         if (context.mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Payment Failed: ${error.toString()}'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       });
//     } catch (e) {
//       print('🚨 Nagad Error: ${e.toString()}');
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error: ${e.toString()}'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }
// }
