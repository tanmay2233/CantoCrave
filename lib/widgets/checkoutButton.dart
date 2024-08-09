import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../Theme/themes.dart';
import '../cart_list_provider.dart';
import '../routes/routes.dart';

class CheckoutButton extends StatelessWidget {
  final double amount;
  final Razorpay _razorpay = Razorpay();

  CheckoutButton(this.amount, {super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<CartListProvider>(
      builder: (context, value, child) => Padding(
        padding:
            EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1),
        child: InkWell(
          onTap: () {
            var options = {
              'key': 'rzp_test_GcZZFDPP0jHtC4',
              'amount': 100 * amount,
              'name': 'CantoCrave',
              'prefill': {
                'contact': '9327497760',
                'email': 'tanmaykamleshjain@gmail.com'
              }
            };

            // Attach context to the Razorpay callbacks
            _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                (PaymentSuccessResponse response) {
              _handlePaymentSuccess(response, context);
            });
            _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                (PaymentFailureResponse response) {
              _handlePaymentError(response, context);
            });

            _razorpay.open(options);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(size.width * 0.05),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 208, 0),
                  Color.fromARGB(255, 252, 248, 50)
                ],
              ),
            ),
            width: size.width * 0.5,
            height: size.height * 0.05,
            child: Text(
              "Checkout",
              style: TextStyle(
                color: MyTheme.canvasDarkColor,
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.037,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clear Razorpay instance
    _razorpay.clear();
    dispose();
  }

  void _handlePaymentSuccess(
      PaymentSuccessResponse response, BuildContext context) {
    // Redirect to the MyOrders page after successful payment
    CartListProvider obj = new CartListProvider();
    obj.placeOrderAndUploadItems(context);
    Navigator.pushNamed(context, MyRoutes.myOrdersPageRoute);
  }

  void _handlePaymentError(
      PaymentFailureResponse response, BuildContext context) {
    // Redirect to the MyOrders page even if the payment fails
    Navigator.pushNamed(context, MyRoutes.cartRoute);
  }
}
