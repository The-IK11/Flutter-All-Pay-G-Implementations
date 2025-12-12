import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';
import 'package:all_payment_gateway/features/all_payment_button_screen/all_payment_button_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _lottieAvailable = false;

  @override
  void initState() {
    super.initState();
    // Check availability then wait 2 seconds and navigate
    _checkLottieAsset().then((available) {
      if (mounted) setState(() => _lottieAvailable = available);
    }).whenComplete(() {
      Timer(const Duration(seconds: 2), () {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => const AllPaymentButtonScreen(),
        ));
      });
    });
  }

  Future<bool> _checkLottieAsset() async {
    const path = 'assets/lotties/online_payment.json';
    try {
      final s = await rootBundle.loadString(path);
      if (s.trim().isEmpty) return false;
      return s.trimLeft().startsWith('{');
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: _lottieAvailable
              ? Lottie.asset(
                  'assets/lotties/online_payment.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                )
              : const SizedBox(
                  width: 120,
                  height: 120,
                  child: Center(child: CircularProgressIndicator()),
                ),
        ),
      ),
    );
  }
}
