import 'package:flutter/material.dart';
import 'package:flutter_nagad/flutter_nagad.dart';
import 'package:get/get.dart';
import 'package:nagad_payment_gateway/nagad_payment_gateway.dart';

class NagadPay {
  NagadPay.internals();

  final nagad = Nagad(
    credentials: const NagadCredentials(
      merchantID: '683002007104225', // Nagad sandbox merchant ID
      merchantPrivateKey: '''MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCJakyLqojWTDAVUdNJLvuXhROV+LXymqnukBrmiWwTYnJYm9r5cKHj1hYQRhU5eiy6NmFVJqJtwpxyyDSCWSoSmIQMoO2KjYyB5cDajRF45v1GmSeyiIn0hl55qM8ohJGjXQVPfXiqX6IWaRN4SYVCxJm6hb7cQFR5BlpPpqOss5ypNkPpO8Oz/CFKTZGY6AWhGT+VSjpnwAUcxBb/0Ah6Jjj8vPCvmgxhPjc7kPqGK6hHxvkyAuAXP8TOpCJEBqbNprmEIJkSyLqbT1WvXtRNwuEW70oy6pAeqM+CUHPmzNh4wvcJBVT+fBKx1gNEaG+jBKbE8kjXdXv+VO/B9Md1AgMBAAECggEAIY6KJIyYjYmkxQTBNO6J7g/aD4UyQhZgpgjnBVZiflNRrZA+jLgVzMg3CZmkqwXN3zv91B5N7WQ8H7t7DDEiJZvGFLBH4U0Z9k44D5Uu5OLknQPqSJgKKs9rX0pRAm3gqclJLx7IyfJZEnDVYNXoDKJ0A7P5hCE4VOsBPDrr1pGKXPQoV6SLaZCm6qxmLDJLz4IyKJT7QfTLB/pqPeFXz0twWXjLXAWTZE1QLUj2nHChW5H7n2fPDRJPCUkCH8N/T0Q7rJVBrqUckG+pCTYmKDV1R8dZXaM6OKMzwClYmJh2cF3bR2Rh6CxHl7mUNHKXnpWdTjfTCPfpSuKrCFLxAQKBgQC+7pPP1oV5gP8z+3o7ItJI/5S0N2Kv2/OvNrknFNuCqaG0w2zAFjP8F7QH3LqBL4rV7NhJqNvPwQzY9k3f+1sR3xV3xD9R8f5Av3K0jqULCkxhCQIDAQABAoIBAQCJakyLqojWTDAVUdNJLvuXhROV+LXymqnukBrmiWwTYnJYm9r5cKHj1hYQRhU5eiy6NmFVJqJtwpxyyDSCWSoSmIQMoO2KjYyB5cDajRF45v1GmSeyiIn0hl55qM8ohJGjXQVPfXiqX6IWaRN4SYVCxJm6hb7cQFR5BlpPpqOss5ypNkPpO8Oz/CFKTZGY6AWhGT+VSjpnwAUcxBb/0Ah6Jjj8vPCvmgxhPjc7kPqGK6hHxvkyAuAXP8TOpCJEBqbNprmEIJkSyLqbT1WvXtRNwuEW70oy6pAeqM+CUHPmzNh4wvcJBVT+fBKx1gNEaG+jBKbE8kjXdXv+VO/B9Md1''', // Sandbox private key
      pgPublicKey: '''MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjq7W8mTxIxnmElnbVdOqpYdtHhxV9XpyPpBvF7xNzCkbvXYqy1ZXkLqHX5BG3t7RwVQ6MhGNw/qRPwcfRJFl5+1E50lxLl3VLlVQVqUr4dqLPBFVdVqC0OYFxOfN7z7FGcq7OIRTCc1KYZ6pXV1Qv2xHjjZlLj0Yl3KgBNQxo7yGNdOmLjLjq9xDKPqDqQZLJg4V5Rqe5R7YqsL5qYpXDVZqDJqxXrQZCnqXx3WqXqHxqXVqXqQZxqXVqXqZqXVqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQIDAQAB''', // Sandbox public key
      isSandbox: true, // set false for production
    ),
  );

  void setupMerchantInfo() {
    nagad.setAdditionalMerchantInfo({
      'serviceName': 'Brand',
      'serviceLogoURL':
          'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png',
      'additionalFieldNameEN': 'Type',
      'additionalFieldNameBN': 'টাইপ',
      'additionalFieldValue': 'Payment',
    });
  }

  Future<NagadResponse?> makePayment(BuildContext context, double amount) async {
    // Generating a unique order ID
    String orderId = 'order${DateTime.now().millisecondsSinceEpoch}';

    try {
      // Initiating a regular payment
      NagadResponse nagadResponse = await nagad.regularPayment(
        context,
        amount: amount,
        orderId: orderId,
      );

      return nagadResponse;
    } catch (e) {
      // Handling errors
      print('Nagad Payment Failed: ${e.toString()}');
      return null;
    }
  }
}