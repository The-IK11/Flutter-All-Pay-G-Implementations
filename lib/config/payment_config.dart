import 'package:flutter_dotenv/flutter_dotenv.dart';

class PaymentConfig {
  // Helper to check if env value is valid (not null and not empty)
  static String _getEnvOrDefault(String key, String defaultValue) {
    final value = dotenv.env[key];
    return (value != null && value.isNotEmpty) ? value : defaultValue;
  }

  // Nagad Sandbox Credentials
  static String get nagadMerchantId =>
      _getEnvOrDefault('NAGAD_MERCHANT_ID', '683002007104225');

  static String get nagadMerchantPrivateKey => _getEnvOrDefault(
      'NAGAD_MERCHANT_PRIVATE_KEY',
      '''MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCJakyLqojWTDAVUdNJLvuXhROV+LXymqnukBrmiWwTYnJYm9r5cKHj1hYQRhU5eiy6NmFVJqJtwpxyyDSCWSoSmIQMoO2KjYyB5cDajRF45v1GmSeyiIn0hl55qM8ohJGjXQVPfXiqX6IWaRN4SYVCxJm6hb7cQFR5BlpPpqOss5ypNkPpO8Oz/CFKTZGY6AWhGT+VSjpnwAUcxBb/0Ah6Jjj8vPCvmgxhPjc7kPqGK6hHxvkyAuAXP8TOpCJEBqbNprmEIJkSyLqbT1WvXtRNwuEW70oy6pAeqM+CUHPmzNh4wvcJBVT+fBKx1gNEaG+jBKbE8kjXdXv+VO/B9Md1AgMBAAECggEAIY6KJIyYjYmkxQTBNO6J7g/aD4UyQhZgpgjnBVZiflNRrZA+jLgVzMg3CZmkqwXN3zv91B5N7WQ8H7t7DDEiJZvGFLBH4U0Z9k44D5Uu5OLknQPqSJgKKs9rX0pRAm3gqclJLx7IyfJZEnDVYNXoDKJ0A7P5hCE4VOsBPDrr1pGKXPQoV6SLaZCm6qxmLDJLz4IyKJT7QfTLB/pqPeFXz0twWXjLXAWTZE1QLUj2nHChW5H7n2fPDRJPCUkCH8N/T0Q7rJVBrqUckG+pCTYmKDV1R8dZXaM6OKMzwClYmJh2cF3bR2Rh6CxHl7mUNHKXnpWdTjfTCPfpSuKrCFLxAQKBgQC+7pPP1oV5gP8z+3o7ItJI/5S0N2Kv2/OvNrknFNuCqaG0w2zAFjP8F7QH3LqBL4rV7NhJqNvPwQzY9k3f+1sR3xV3xD9R8f5Av3K0jqULCkxhCQIDAQABAoIBAQCJakyLqojWTDAVUdNJLvuXhROV+LXymqnukBrmiWwTYnJYm9r5cKHj1hYQRhU5eiy6NmFVJqJtwpxyyDSCWSoSmIQMoO2KjYyB5cDajRF45v1GmSeyiIn0hl55qM8ohJGjXQVPfXiqX6IWaRN4SYVCxJm6hb7cQFR5BlpPpqOss5ypNkPpO8Oz/CFKTZGY6AWhGT+VSjpnwAUcxBb/0Ah6Jjj8vPCvmgxhPjc7kPqGK6hHxvkyAuAXP8TOpCJEBqbNprmEIJkSyLqbT1WvXtRNwuEW70oy6pAeqM+CUHPmzNh4wvcJBVT+fBKx1gNEaG+jBKbE8kjXdXv+VO/B9Md1''');

  static String get nagadPgPublicKey => _getEnvOrDefault(
      'NAGAD_PG_PUBLIC_KEY',
      '''MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjq7W8mTxIxnmElnbVdOqpYdtHhxV9XpyPpBvF7xNzCkbvXYqy1ZXkLqHX5BG3t7RwVQ6MhGNw/qRPwcfRJFl5+1E50lxLl3VLlVQVqUr4dqLPBFVdVqC0OYFxOfN7z7FGcq7OIRTCc1KYZ6pXV1Qv2xHjjZlLj0Yl3KgBNQxo7yGNdOmLjLjq9xDKPqDqQZLJg4V5Rqe5R7YqsL5qYpXDVZqDJqxXrQZCnqXx3WqXqHxqXVqXqQZxqXVqXqZqXVqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQZxqXVqXqZqXqQIDAQAB''');

  static bool get nagadIsSandbox {
    final value = dotenv.env['NAGAD_IS_SANDBOX'];
    return value == 'true' || value == null || value.isEmpty;
  }

  // SSLCommerz Credentials
  static String get sslCommerzStoreId =>
      _getEnvOrDefault('SSLCOMMERZ_STORE_ID', 'testbox');

  static String get sslCommerzStorePassword =>
      _getEnvOrDefault('SSLCOMMERZ_STORE_PASSWORD', 'qwerty');

  static bool get sslCommerzIsSandbox {
    final value = dotenv.env['SSLCOMMERZ_IS_SANDBOX'];
    return value == 'true' || value == null || value.isEmpty;
  }

  // bKash Credentials
  static String get bkashUsername =>
      _getEnvOrDefault('BKASH_USERNAME', 'sandboxTokenizedUser02');

  static String get bkashPassword =>
      _getEnvOrDefault('BKASH_PASSWORD', 'sandboxTokenizedUser02@12345');

  static String get bkashAppKey =>
      _getEnvOrDefault('BKASH_APP_KEY', '4f6o0cjiki2rfm34kfdadl1eqq');

  static String get bkashAppSecret => _getEnvOrDefault('BKASH_APP_SECRET',
      '2is7hdktrekvrbljjh44ll3d9l1dtjo4pasmjvs5vl5qr3fug4b');

  static bool get bkashIsSandbox {
    final value = dotenv.env['BKASH_IS_SANDBOX'];
    return value == 'true' || value == null || value.isEmpty;
  }

  /// Stripe Credentials
    static String get striptPublishableKey =>
      _getEnvOrDefault('STRIPE_PUBLISHABLE_KEY', 'test_publishable_key');


    static String get stripeSecretKey =>
      _getEnvOrDefault('STRIPE_SECRET_KEY', 'test_secret_key');
          static String get payPalSecretKey=>
      _getEnvOrDefault('PAYPAL_CLIENT_SECRET', 'test_secret_key');
          static String get payPalClientId =>
      _getEnvOrDefault('PAYPAL_CLIENT_ID', 'test_client_id');

      static String get payStackPublicKey =>
      _getEnvOrDefault('PAYSTACK_PUBLIC_KEY', 'test_public_key');

      static String get payStackSecretKey =>
      _getEnvOrDefault('PAYSTACK_SECRET_KEY', 'test_secret_key');
     
      // Flutter Wave Credentials
      static String get flutterWavePublicKey =>
      _getEnvOrDefault('FLUTTERWAVE_PUBLIC_KEY', 'test_public_key');
      static String get flutterWaveSecretKey =>
      _getEnvOrDefault('FLUTTERWAVE_SECRET_KEY', 'test_secret_key');
      static String get flutterWaveEncryptionKey =>
      _getEnvOrDefault('FLUTTERWAVE_ENCRYPTION_KEY', 'test  _encryption_key');

}   