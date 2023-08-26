import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Theme/themes.dart';
import '../cart_list_provider.dart';

class CheckoutButton extends StatelessWidget {
  CheckoutButton({super.key});

  final String beneficiaryName = "Kamlesh Jain";
  final String upiId = "kamleshjain762011@okicici"; // UPI ID of the beneficiary
  final String amount = '1.0';
  final String note = 'NOte';
  final String senderName = 'tanmayJ';

  String generateUpiUrl(
      String receiverUpi, String receiverName, String amount, String note) {
    // Construct the UPI URL
    final String scheme = 'upi://pay';
    final Map<String, String> params = {
      'pa': receiverUpi, // Payee VPA (Virtual Payment Address)
      'pn': receiverName, // Payee Name
      'mc': '', // Merchant Code (if applicable)
      'tid':
          'txnId12345', // Transaction ID (unique identifier for your transaction)
      'tn': note, // Transaction Note
      'am': amount, // Amount
      'cu': 'INR', // Currency (INR for Indian Rupees)
      'url': 'your-transaction-url', // Transaction URL (if applicable)
    };

    // Combine the scheme and parameters
    String upiUrl = '$scheme?';
    params.forEach((key, value) {
      upiUrl += '$key=$value&';
    });

    return upiUrl;
  }


 
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<CartListProvider>(
      builder: (context, value, child) => 
      Padding(
        padding: EdgeInsets.only(left: size.width*0.1, right: size.width*0.1),
        child: InkWell(
            onTap: () async {

              await value.uploadCartItems();
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