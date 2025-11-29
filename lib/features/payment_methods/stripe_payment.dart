import 'package:all_payment_gateway/config/payment_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripePaymentService{

StripePaymentService.internal();

Future<void> makePayment()async{
  try{
   
String ?result= await createPayment(10.0, 'USD');

if(result==null) return ;
// Ensure flutter_stripe is initialized with your publishable key (client-side).
// Do NOT use the secret key here — the secret key must only be used on a
// trusted server when creating PaymentIntents.
Stripe.publishableKey = PaymentConfig.striptPublishableKey;

await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
  paymentIntentClientSecret: result,
  merchantDisplayName: 'Ibrahim Khalil',
));

await _proceedPayment();
  }catch(e){
print(e);
  }
}

Future<String?> createPayment(double ammount, String currency)async{
try{
  final Dio dio = Dio();
    // Basic validation: make sure we have a secret key
    if (PaymentConfig.stripeSecretKey.isEmpty) {
      print('Stripe secret key is missing. Set PaymentConfig.stripeSecretKey');
      return null;
    }

    // Stripe expects form-url-encoded body with amount as integer (in cents)
    final Map<String, dynamic> body = {
      'amount': _calculatedAmount(ammount),
      'currency': currency,
    'payment_method_types[]': 'card',
    };

    try {
      final response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: body,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'Authorization': 'Bearer ${PaymentConfig.stripeSecretKey}',
            "Content-Type": "application/x-www-form-urlencoded"
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Payment Intent Created');
        // Stripe returns a `client_secret` on the PaymentIntent which the
        // client must use with the payment sheet. Previously we returned
        // the PaymentIntent `id` (pi_...) which caused the "Invalid Payment
        // Intent client secret" error. Return the `client_secret` instead.
        return response.data['client_secret'];
      }

      // If status is not 200/201, print full response for diagnosis
      print('Failed to create Payment Intent: ${response.statusCode} - ${response.statusMessage}');
      print('Response body: ${response.data}');
      return null;
    } on DioException catch (e) {
      // DioException contains response with server error details (Stripe will
      // include a structured error object). Print it to help debugging.
      if (e.response != null) {
        print('DioException response status: ${e.response?.statusCode}');
        print('DioException response data: ${e.response?.data}');
      } else {
        print('DioException without response: ${e.message}');
      }
      return null;
    }
}catch(e){
  print(e); 
}

  return null;

}

Future<void>_proceedPayment()async{
  try{
    await Stripe.instance.presentPaymentSheet(

      );

    print('Payment completed successfully!');
  }catch(e){
    print('Payment failed: $e');
  }
} 
_calculatedAmount(double amount){
  // Stripe requires the amount as an integer in the smallest currency unit
  // (e.g. cents). Use round() to avoid floating point strings like "1000.0".
  return (amount * 100).round().toString();
}}