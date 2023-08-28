import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

import '../Theme/themes.dart';
import '../cart_list_provider.dart';
import '../routes/routes.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool paid = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Payment Page'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor]),
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              const Text("UPI Payment QRCode with Amount",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Consumer<CartListProvider>(
                builder: (context, value, child) => 
                FutureBuilder(
                  future: value.getCartTotal(),
                  builder: (context, snapshot) {
                    double amount = snapshot.data ?? 0.0;
                      return  UPIPaymentQRCode(
                      upiDetails: UPIDetails(
                        upiID: "kamleshjain762011@okicici",
                        payeeName: "CantoCrave",
                        amount: amount,
                        transactionNote: "To Canteen"),
                      size: 220,
                      upiQRErrorCorrectLevel: UPIQRErrorCorrectLevel.low,
                    );
                  },
                ),
              ),
              Text(
                "Scan QR to Pay",
                style: TextStyle(color: Colors.grey[600], letterSpacing: 1.2),
              ),

              SizedBox(height: size.height*0.1,),

              Consumer<CartListProvider>(
                builder: (context, value, child) => 
                Padding(
                  padding: EdgeInsets.only(left: size.width*0.1, right: size.width*0.1),
                  child: InkWell(
                    onTap: () {
                      paid ?  value.placeOrderAndUploadItems(context) : 
                        Navigator.pushReplacementNamed(context, MyRoutes.myOrdersPageRoute);
                      setState(() {
                        paid = false;
                      });
                    },
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
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
              width: paid ? size.width*0.5 : size.width*0.1,
              height: size.height*0.05,
              child: 
              paid ? Text("Place Order", style: TextStyle(color: MyTheme.canvasDarkColor,
                fontWeight: FontWeight.bold,
                fontSize: size.width*0.037
              ))
              :
              Icon(CupertinoIcons.right_chevron)
            ),
          ),
      ),
    // );
          )],
          ),
        ),
    );
  }
}
