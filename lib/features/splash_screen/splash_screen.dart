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

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  bool _lottieAvailable = false;
  late final AnimationController _textController;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    // prepare text animation immediately so animations are available on first build
    _textController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _scaleAnim = Tween<double>(begin: 0.9, end: 1.05).animate(CurvedAnimation(parent: _textController, curve: Curves.easeInOut));
    _fadeAnim = Tween<double>(begin: 0.6, end: 1.0).animate(CurvedAnimation(parent: _textController, curve: Curves.easeInOut));
    _textController.repeat(reverse: true);

    // Check availability (sets state when done)
    _checkLottieAsset().then((available) {
      if (mounted) setState(() => _lottieAvailable = available);
    });

    // navigate after 2 seconds regardless
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const AllPaymentButtonScreen(),
      ));
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _lottieAvailable
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
              const SizedBox(height: 18),
              ScaleTransition(
                scale: _scaleAnim,
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: const Text(
                    'All Payment Gateway',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
