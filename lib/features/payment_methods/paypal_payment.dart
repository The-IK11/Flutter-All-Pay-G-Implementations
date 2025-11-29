
import 'package:all_payment_gateway/config/payment_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
class PayPalPayment {

  PayPalPayment.internal();


 MakePayment(BuildContext context) {
    return  PaypalCheckoutView(
                  sandboxMode: true,
                  clientId: PaymentConfig.payPalClientId,
                  secretKey: PaymentConfig.payPalSecretKey,
                    
        // returnURL: "RETURN_URL",
        // cancelURL: "CANCEL_URL",
                  transactions: [
                    {
                      "amount": {
                        "total": '10',
                        "currency": "USD",
                        "details": {
                          "subtotal": '10',
                          "shipping": '0',
                          "shipping_discount": 0
                        }
                      },
                      "description": "Payment for service",
                      "item_list": {
                        "items": [
                          {
                            "name": "My Product",
                            "quantity": 1,
                            "price": '10',
                            "currency": "USD"
                          }
                        ],
                      }
                    }
                  ],
                  note: "Thank you for your purchase!",
                  onSuccess: (Map params) async {
                    print("SUCCESS: $params");
                    Navigator.pop(context);
                  },
                  onError: (error) {
                    print("ERROR: $error");
                    Navigator.pop(context);
                  },
                  onCancel: () {
                    print('CANCELLED');
                    Navigator.pop(context);
                  },
                );
       
  }
}