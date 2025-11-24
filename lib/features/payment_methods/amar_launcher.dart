import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

/// Launches Aamarpay by requesting the payment URL first, then opening an
/// in-app WebView. This avoids navigating to an intermediate screen before
/// the payment URL is ready.
Future<void> launchAamarpay(BuildContext context,
    {required double amount,
    String storeID = 'aamarpaytest',
    String signature = 'dbb74894e82415a2f7ff0ec3a97e4183',
    bool isSandBox = true,
    String successUrl = 'https://example.com/payment/confirm',
    String failUrl = 'https://example.com/payment/fail',
    String cancelUrl = 'https://example.com/payment/cancel',
    String currency = 'BDT'}) async {
  final transactionID = 'TRX${DateTime.now().millisecondsSinceEpoch}';
  final postUrl = isSandBox
      ? 'https://sandbox.aamarpay.com/jsonpost.php'
      : 'https://secure.aamarpay.com/jsonpost.php';

  final payload = {
    'store_id': storeID,
    'tran_id': transactionID,
    'success_url': successUrl,
    'fail_url': failUrl,
    'cancel_url': cancelUrl,
    'amount': amount.toStringAsFixed(2),
    'currency': currency,
    'signature_key': signature,
    'desc': 'Payment from app',
    'cus_name': 'Customer',
    'cus_email': 'no-reply@example.com',
    'cus_add1': 'Dhaka',
    'cus_add2': 'Dhaka',
    'cus_city': 'Dhaka',
    'cus_state': 'Dhaka',
    'cus_postcode': '0',
    'cus_country': 'Bangladesh',
    'cus_phone': '0000000000',
    'opt_a': '',
    'opt_b': '',
    'opt_c': '',
    'opt_d': '',
    'type': 'json'
  };

  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => const Center(child: CircularProgressIndicator()),
  );

  try {
    final resp = await http.post(Uri.parse(postUrl),
        headers: {'Content-Type': 'application/json'}, body: json.encode(payload));

    Navigator.of(context).pop(); // remove loading

    if (resp.statusCode != 200) {
      _showError(context, 'Payment request failed (status ${resp.statusCode})');
      return;
    }

    dynamic body = json.decode(resp.body);

    // Sandbox usually returns a JSON with payment_url. Production sometimes
    // returns a JSON string, but decoding above should handle both.
    String? paymentUrl;
    if (body is Map && body.containsKey('payment_url')) {
      paymentUrl = body['payment_url'] as String?;
    } else if (body is String) {
      try {
        final decoded = json.decode(body);
        if (decoded is Map && decoded.containsKey('payment_url')) {
          paymentUrl = decoded['payment_url'] as String?;
        }
      } catch (_) {}
    }

    if (paymentUrl == null || paymentUrl.isEmpty) {
      _showError(context, 'Could not obtain payment URL from Aamarpay');
      return;
    }

    // Open in-app webview and monitor navigation to detect success/fail/cancel
    final result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => _AamarWebView(
        url: paymentUrl!,
        successUrl: successUrl,
        failUrl: failUrl,
        cancelUrl: cancelUrl,
      ),
    ));

    // result will be the final url that triggered navigation or null
    if (result != null && result is String) {
      if (result.contains(successUrl)) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Payment succeeded')));

        // After successful payment, try to return to the app's root (first)
        // route using the root navigator (handles nested navigators). If that
        // fails, fall back to the local navigator, then a single pop.
        Future.microtask(() {
          try {
            // Prefer the root navigator to ensure we reach the app-level
            // first route even when nested navigators (dialogs, shells) are
            // present.
            Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);
          } catch (_) {
            try {
              Navigator.of(context).popUntil((route) => route.isFirst);
            } catch (_) {
              if (Navigator.of(context).canPop()) Navigator.of(context).pop();
            }
          }
        });
      } else if (result.contains(cancelUrl)) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Payment cancelled')));
      } else if (result.contains(failUrl)) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Payment failed')));
      }
    }
  } catch (e) {
    Navigator.of(context).pop();
    _showError(context, 'Payment request error: $e');
  }
}

void _showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

class _AamarWebView extends StatefulWidget {
  final String url;
  final String successUrl;
  final String failUrl;
  final String cancelUrl;

  const _AamarWebView(
      {Key? key,
      required this.url,
      required this.successUrl,
      required this.failUrl,
      required this.cancelUrl})
      : super(key: key);

  @override
  State<_AamarWebView> createState() => _AamarWebViewState();
}

class _AamarWebViewState extends State<_AamarWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    _controller.setNavigationDelegate(NavigationDelegate(
      onNavigationRequest: (req) {
        final url = req.url;
        if (url.contains(widget.successUrl) ||
            url.contains(widget.failUrl) ||
            url.contains(widget.cancelUrl)) {
          Navigator.of(context).pop(url);
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ));
    _controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aamarpay'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
