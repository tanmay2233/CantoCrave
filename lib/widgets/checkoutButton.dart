import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/cart_list_provider.dart';
import 'package:provider/provider.dart';

import '../Theme/themes.dart';

class CheckoutButton extends StatelessWidget {
  CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<CartListProvider>(
      builder: (context, value, child) => 
      Padding(
        padding: EdgeInsets.only(left: size.width*0.1, right: size.width*0.1),
        child: InkWell(
            onTap: () async {
              final res = await EasyUpiPaymentPlatform.instance.startPayment(
              EasyUpiPaymentModel(
                payeeVpa: 'kamleshjain762011@okicici',
                payeeName: 'TJ',
                amount: 1.0,
                description: 'Testing payment',
              ),
            );
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(size.width*0.05),
                gradient: const LinearGradient(
                  colors: [
                  Color.fromARGB(255, 255, 208, 0),
                  Color.fromARGB(255, 252, 248, 50)
                ])
              ),
              width: size.width*0.5,
              height: size.height*0.05,
              child: Text("Checkout", style: TextStyle(color: MyTheme.canvasDarkColor,
                fontWeight: FontWeight.bold,
                fontSize: size.width*0.037
              ),)
            ),
          ),
      ),
    );
  }    
}       