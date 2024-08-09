import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  Razorpay _razorpay = Razorpay();

  @override
  Widget build(BuildContext context) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: OutlinedButton(
            onPressed: () {
              var options = {
                'key': 'rzp_test_GcZZFDPP0jHtC4',
                'amount': 100,
                'name': 'Acme Corp.',
                'description': 'Fine T-Shirt',
                'prefill': {
                  'contact': '8888888888',
                  'email': 'test@razorpay.com'
                }
              };
              _razorpay.open(options);
            },
            child: Text('Make Payment')),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    Fluttertoast.showToast(msg: 'Payment Successful');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Fluttertoast.showToast(msg: 'Payment Successful');
  }
}
