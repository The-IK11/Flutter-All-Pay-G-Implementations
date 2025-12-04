3️⃣ iOS Setup (Required for Apple Pay)

Open ios/Runner.xcworkspace in Xcode

Go to Signing & Capabilities → + Capability → Apple Pay

Add your merchant ID (the one used in your JSON)

Make sure your team & signing are correct

Build for a real iOS device (Apple Pay does not work on simulator for real payments)


5️⃣ Backend Setup (Mandatory)

Apple Pay will return a payment token, but it does NOT charge money by itself.

You must send the token to your backend

Use Stripe / Braintree / your own payment gateway to complete the payment

Example for Stripe (Node.js):

const stripe = require("stripe")("sk_live_xxx");

app.post("/pay", async (req, res) => {
  const { paymentToken, amount } = req.body;

  const paymentIntent = await stripe.paymentIntents.create({
    amount: amount * 100, // in cents
    currency: "usd",
    payment_method_data: {
      type: "card",
      card: {
        token: paymentToken,
      },
    },
    confirm: true,
  });

  res.json(paymentIntent);
});