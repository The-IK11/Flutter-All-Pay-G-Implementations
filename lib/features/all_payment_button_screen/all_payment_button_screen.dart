import 'package:all_payment_gateway/features/payment_methods/amar_pay.dart';
import 'package:all_payment_gateway/features/payment_methods/amar_launcher.dart';
import 'package:all_payment_gateway/features/payment_methods/bkash_pay.dart';
import 'package:all_payment_gateway/features/payment_methods/flutter_wave_payment_gateway.dart';
import 'package:all_payment_gateway/features/payment_methods/nagad_pay.dart';
import 'package:all_payment_gateway/features/payment_methods/paypal_payment.dart';
import 'package:all_payment_gateway/features/payment_methods/paystake_payment_method.dart';
import 'package:all_payment_gateway/features/payment_methods/razor_pay.dart';
import 'package:all_payment_gateway/features/payment_methods/sslcommerz_pay.dart';
import 'package:all_payment_gateway/features/payment_methods/stripe_payment.dart';
import 'package:all_payment_gateway/features/payment_methods/surjopay_pay.dart';
import 'package:all_payment_gateway/features/payment_methods/uddokta_pay.dart';
import 'package:all_payment_gateway/features/payment_methods/google_pay_and_apple_pay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllPaymentButtonScreen extends StatelessWidget {
	const AllPaymentButtonScreen({super.key});

	void _showPlaceholder(BuildContext context, String title) {
		ScaffoldMessenger.of(context).showSnackBar(
			SnackBar(content: Text('Tapped $title — implement integration')),
		);
	}

	Widget _sectionTitle(String title, String subtitle) {
		return Padding(
			padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Text(title,
							style: const TextStyle(
								fontSize: 18,
								fontWeight: FontWeight.w700,
							)),
					const SizedBox(height: 4),
					Text(subtitle,
							style: TextStyle(fontSize: 13, color: Colors.grey[600])),
				],
			),
		);
	}

	Widget _gatewayCard(BuildContext context,
			{required IconData icon,
			required String title,
     VoidCallback? onTap,
			String? subtitle,
			Color? color}) {
		color = color ?? Theme.of(context).colorScheme.primary;
		return Card(
			elevation: 2,
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
			child: InkWell(
				borderRadius: BorderRadius.circular(12),
				onTap: onTap ?? () { _showPlaceholder(context, title);},
				child: Padding(
					padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14),
					child: Row(
						children: [
								Container(
												decoration: BoxDecoration(
													color: _alphaColor(color, 0.12),
													borderRadius: BorderRadius.circular(10),
												),
								padding: const EdgeInsets.all(10),
								child: Icon(icon, color: color, size: 26),
							),
							const SizedBox(width: 12),
							Expanded(
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Text(title,
												style: const TextStyle(
														fontSize: 16, fontWeight: FontWeight.w600)),
										if (subtitle != null) ...[
											const SizedBox(height: 6),
											Text(subtitle,
													style:
															TextStyle(fontSize: 13, color: Colors.grey[600])),
										]
									],
								),
							),
							const Icon(Icons.chevron_right, color: Colors.grey),
						],
					),
				),
			),
		);
	}
    

	@override
	Widget build(BuildContext context) {
		final spacer = const SizedBox(height: 8);

		return Scaffold(
			appBar: AppBar(
				title: const Text('Payment Gateways'),
				centerTitle: true,
				elevation: 0,
			),
			body: SafeArea(
				child: SingleChildScrollView(
					padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Container(
								width: double.infinity,
								padding: const EdgeInsets.all(14),
												decoration: BoxDecoration(
													color: _alphaColor(Theme.of(context).colorScheme.primary, 0.06),
													borderRadius: BorderRadius.circular(14),
												),
								child: Row(
									children: [
										const Icon(Icons.payments, size: 34),
										const SizedBox(width: 12),
										Expanded(
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: const [
													Text('Choose a payment method',
															style: TextStyle(
																	fontSize: 16, fontWeight: FontWeight.w600)),
													SizedBox(height: 4),
													Text('Tap any option to configure or test it',
															style: TextStyle(fontSize: 13)),
												],
											),
										),
									],
								),
							),

							const SizedBox(height: 18),

							// Local / Regional
							_sectionTitle('Local / Regional', 'Used for payments inside a specific country'),
							spacer,
							_gatewayCard(context,
              onTap: (){
                BkashPay.internals().BkashPayment(context);
              },
									icon: Icons.mobile_friendly,
									title: 'bKash',
									subtitle: 'Bangladesh — very common for BD apps',
									color: Colors.green),
							_gatewayCard(context,
              onTap: (){
  //NagadPay.internals().makePayment(context, 10);

				ScaffoldMessenger.of(context).showSnackBar(
					const SnackBar(
						content: Text('Nagad is now unavailable, Need sandbox credentials from Nagad team'),
						duration: Duration(seconds: 2),
						behavior: SnackBarBehavior.floating,
					),
				);
            
              },
									icon: Icons.account_balance_wallet,
									title: 'Nagad',
									subtitle: 'Bangladesh — mobile wallet',
									color: Colors.deepOrange),
							_gatewayCard(context,
									icon: Icons.account_balance,
									title: 'Rocket (DBBL)',
									subtitle: 'Bangladesh — mobile banking',
									color: Colors.teal),
							_gatewayCard(context,
							onTap: () {
								SslCommerzPay.internals().sslcommerz(amount: 100.0);
							},
									icon: Icons.check,
									title: 'SSLCOMMERZ',
									subtitle: 'Bangladesh — supports bKash/Nagad/Card',
									color: Colors.indigo),
						 
						
													_gatewayCard(context,
													onTap: () async {
														// Launch Aamarpay: request payment URL first, then open webview
														await launchAamarpay(context, amount: 200.0);

														////With using AmarPay package
														// Navigator.push(
														// 	context,
														// 	MaterialPageRoute(
														// 		builder: (context) => MyPay(),
														// 	),
														// );
													},
														icon: Icons.account_balance_wallet,
														title: 'AamarPay',
														subtitle: 'Bangladesh — supports cards, mobile banking & wallets',
														color: Colors.deepPurple),
							_gatewayCard(context,
									icon: Icons.wb_sunny,
									title: 'SurjoPay',
									subtitle: 'Bangladesh — multi-currency payment solution',
									color: Colors.amber,
									onTap: () {
										final surjoPay = SurjoPay.internals();
										surjoPay.makePayment(context, 100.0);
									}),
							_gatewayCard(context,
							onTap: (){
								UddoktaPayPayment.internals().makePayment(100.0, context);
							},
									icon: Icons.business,
									title: 'UddoktaPay',
									subtitle: 'Bangladesh — merchant payment gateway',
									color: Colors.blueGrey),


							const SizedBox(height: 18),

							// International
							_sectionTitle('International', 'Used for global payments'),
							spacer,
							_gatewayCard(context,
							onTap: () {
							  StripePaymentService.internal().makePayment();
							},
									icon: Icons.credit_card,
									title: 'Stripe',
									subtitle: 'Easiest, secure, recommended',
									color: Colors.blue),
							_gatewayCard(context,
									icon: Icons.account_balance,
									title: 'PayPal',
									onTap: () {
									// Navigate to the PayPal checkout view. PayPalPayment.MakePayment
									// returns the widget (PaypalCheckoutView) and expects the current
									// BuildContext for callbacks, so we push it as a new route.
									Navigator.of(context).push(
										MaterialPageRoute(
											builder: (_) => PayPalPayment.internal().MakePayment(context),
										),
									);
									},
									subtitle: 'Mostly for web / business users',
									color: Colors.indigo),
							_gatewayCard(context,
							onTap: (){
								RazorPay.internal().razorPay(100.0);
							},
									icon: Icons.payment,
									title: 'Razorpay',
									subtitle: 'Popular in India',
									color: Colors.orange),
							_gatewayCard(context,
              onTap: () {
                PayStackPayment.internal().makePayment(context);
              },
									icon: Icons.public,
									title: 'Paystack',
									subtitle: 'Used in Africa & Asia',
									color: Colors.green),
							_gatewayCard(context,
							onTap: (){
								FlutterWavePaymentGateway.interner().makePayment(context);} ,
									icon: Icons.waves,
									title: 'Flutterwave',
									subtitle: 'Wide international support',
									color: Colors.cyan),

							const SizedBox(height: 18),

							_sectionTitle('Card Processing', 'Processed via Stripe / SSLCOMMERZ'),
							spacer,
							_gatewayCard(context,
								onTap: () {
									Navigator.of(context).push(MaterialPageRoute(builder: (_) {
										return Scaffold(
											appBar: AppBar(title: const Text('Google / Apple Pay')),
											body: Padding(
												padding: const EdgeInsets.all(16.0),
												child: Center(
													child: GooglePayAndApplePay.integerals().getPlatformButton(
														onPaymentResult: (result) {
															ScaffoldMessenger.of(context).showSnackBar(
															SnackBar(content: Text('Payment result: \$result')),
														);
													},
													),
												),
											),
										);

                    
								}));

			//  Navigator.push(context, MaterialPageRoute(builder: (context) => PayPage()),);
								},
								icon: Icons.payment,
								title: 'Google Pay',
								subtitle: 'Tap to pay with Google Pay',
								color: Colors.black,
							),
							_gatewayCard(context,
									icon: Icons.apple,
									title: 'Apple Pay',
									subtitle: 'Tap to pay with Apple Pay',
									color: Colors.black,
									onTap: () { _showPlaceholder(context, 'Apple Pay'); }),
							_gatewayCard(context,
									icon: Icons.credit_card, title: 'Visa / Mastercard', subtitle: 'Via Stripe or SSLCOMMERZ'),
							_gatewayCard(context,
									icon: Icons.payment, title: 'American Express', subtitle: 'Also supported'),

							const SizedBox(height: 18),

							// In-App Purchases
							_sectionTitle('In-App Purchases (IAP)', 'Google Play / Apple App Store — for digital items and subscriptions'),
							spacer,
							_gatewayCard(context,
									icon: Icons.shopping_cart,
									title: 'In-App Purchase',
									subtitle: 'Use in_app_purchase package for consumables/subscriptions',
									color: Colors.brown),

							const SizedBox(height: 20),

							// Footer note
							Padding(
								padding: const EdgeInsets.symmetric(horizontal: 8.0),
								child: Text(
									'Note: Google Pay (GPAY) is not the same as In-App Purchases.',
									style: TextStyle(fontSize: 13, color: Colors.grey[700]),
								),
							),

							const SizedBox(height: 36),
						],
					),
				),
			),
		);
	}

		// Helper to avoid deprecated withOpacity calls
		Color _alphaColor(Color color, double opacity) {
			final int alpha = (opacity * 255).round().clamp(0, 255);
			return color.withAlpha(alpha);
		}
}

