import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPay {
  RazorPay.internal();

  void razorPay(double amount) async {
  final razorPay = Razorpay();

  var options = {
    'key': 'rzp_test_HJG5Rtuy8Xh2NB',
    'amount': amount,
    'name': 'Acme Corp.',
    'description': 'Fine T-Shirt',
    'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
  };

  try {
    razorPay.open(options);

    razorPay.on(
      Razorpay.EVENT_PAYMENT_SUCCESS,
      (PaymentSuccessResponse response) {
        print('Payment success');
        print(response.paymentId);
      },
    );

    razorPay.on(
      Razorpay.EVENT_PAYMENT_ERROR,
          (PaymentFailureResponse response) {
        print('Payment failed');
        print(response.message);
      },
    );

  } catch (e) {
    print('Error ${e.toString()}');
  }
}
}
