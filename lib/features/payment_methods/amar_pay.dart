
import 'package:aamarpay/aamarpay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
// class AmarPayPayment {

//   AmarPayPayment.internals();

//   // final Aamarpay _aamarpay =  Aamarpay(
    
//   //     isSandBox: true, // Set to false for production
//   //     successUrl: "https://your-success-url.com",
//   //     failUrl: "https://your-fail-url.com",
//   //     cancelUrl: "https://your-cancel-url.co;m",
//   //     storeID: "your_store_id",
//   //     transactionID: "",
//   //     transactionAmount: "",
//   //     signature: "generated_signature",
//   //     customerName: "Customer Name",
//   //     customerEmail: "customer@example.com",
//   //     customerMobile: "017XXXXXXXX",
//   //     child: Container(),
//   //   );

//  void makePayment(BuildContext context, double amount) {
//     String uniqueTranId = "TRX${DateTime.now().millisecondsSinceEpoch}";
 
//     Aamarpay(
    
//       isSandBox: true, // Set to false for production
//       successUrl: "https://your-success-url.com",
//       failUrl: "https://your-fail-url.com",
//       cancelUrl: "https://your-cancel-url.co;m",
//       storeID: "aamarpaytest",
//       transactionID: uniqueTranId,
//       transactionAmount: amount.toStringAsFixed(2),
//       signature: "dbb74894e82415a2f7ff0ec3a97e4183",
//       customerName: "Ibrahim Khalil",
//       customerEmail: "ibrahim258159@gmail.com",
//       customerMobile: "01889254301",
//       child: Container(),
//     );
// }
// }

class MyPay extends StatefulWidget {
  final bool autoStart;

  MyPay({this.autoStart = false});

  @override
  _MyPayState createState() => _MyPayState();
}

class _MyPayState extends State<MyPay> {
  bool isLoading = false;
  final GlobalKey _childKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.autoStart) {
      // Wait for the first frame so the child is laid out, then simulate a tap
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _simulateChildTap();
      });
    }
  }

  void _simulateChildTap() {
    try {
      final context = _childKey.currentContext;
      if (context == null) return;
      final box = context.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) return;
      final center = box.localToGlobal(box.size.center(Offset.zero));

      // Synthesize a pointer down/up at the center of the child so the
      // Aamarpay's internal InkWell receives it and triggers the flow.
      GestureBinding.instance.handlePointerEvent(
        PointerDownEvent(position: center, pointer: 1),
      );
      GestureBinding.instance.handlePointerEvent(
        PointerUpEvent(position: center, pointer: 1),
      );
    } catch (e) {
      // Ignore any error — fallback is manual tap
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Aamarpay(
          // This will return a payment url based on failUrl,cancelUrl,successUrl
          returnUrl: (String url) {
            print(url);
          },
          // This will return the payment loading status
          isLoading: (bool loading) {
            setState(() {
              isLoading = loading;
            });
          },
          // This will return the payment event with a message
          status: (EventState event, String message) {
            if (event == EventState.error) {
              setState(() {
                isLoading = false;
              });
            }
          },
          cancelUrl: "example.com/payment/cancel",
          successUrl: "example.com/payment/confirm",
          failUrl: "example.com/payment/fail",
          customerEmail: "masumbillahsanjid@gmail.com",
          customerMobile: "01834760591",
          customerName: "Masum Billah Sanjid",
          signature: "dbb74894e82415a2f7ff0ec3a97e4183",
          storeID: "aamarpaytest", 
          transactionAmount: "200",
          transactionID: "${DateTime.now().millisecondsSinceEpoch}",
        
          description: "test",
          isSandBox: true,
          child: Container(
            key: _childKey,
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    color: Colors.orange,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Payment",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}