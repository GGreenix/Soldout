import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/FirestoreHandler.dart';
import 'payment_configurations.dart' as payment_configurations;
import 'package:pay/pay.dart';

class PaySampleApp extends StatefulWidget {
  PaySampleApp({Key? key}) : super(key: key);

  @override
  _PaySampleAppState createState() => _PaySampleAppState();
}

const _paymentItems = [
  PaymentItem(
    label: 'Total',
    amount: '99.99',
    status: PaymentItemStatus.final_price,
  )
];

class _PaySampleAppState extends State<PaySampleApp> {
  late final Future<PaymentConfiguration> _googlePayConfigFuture;

  @override
  void initState() {
    super.initState();
    _googlePayConfigFuture =
        PaymentConfiguration.fromAsset('default_google_pay_config.json');
  }

  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('tickets'),
        ),
        backgroundColor: Colors.white,
        body:
            // Container(
            //   margin: const EdgeInsets.symmetric(vertical: 20),
            //   child: const Image(
            //     image: AssetImage('assets/images/ts_10_11019a.jpg'),
            //     height: 350,
            //   ),
            // ),
            // const Text(
            //   'Amanda\'s Polo Shirt',
            //   style: TextStyle(
            //     fontSize: 20,
            //     color: Color(0xff333333),
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // const SizedBox(height: 5),
            // const Text(
            //   '\$50.20',
            //   style: TextStyle(
            //     color: Color(0xff777777),
            //     fontSize: 15,
            //   ),
            // ),
            // const SizedBox(height: 15),
            // const Text(
            //   'Description',
            //   style: TextStyle(
            //     fontSize: 15,
            //     color: Color(0xff333333),
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // const SizedBox(height: 5),
            // const Text(
            //   'A versatile full-zip that you can wear all day long and even...',
            //   style: TextStyle(
            //     color: Color(0xff777777),
            //     fontSize: 15,
            //   ),
            // ),
            // Example pay button configured using an asset
            // FutureBuilder<PaymentConfiguration>(
            //     future: _googlePayConfigFuture,
            //     builder: (context, snapshot) => snapshot.hasData
            //         ? GooglePayButton(
            //             paymentConfiguration: snapshot.data!,
            //             paymentItems: _paymentItems,
            //             type: GooglePayButtonType.buy,
            //             margin: const EdgeInsets.only(top: 15.0),
            //             onPaymentResult: onGooglePayResult,
            //             loadingIndicator: const Center(
            //               child: CircularProgressIndicator(),
            //             ),
            //           )
            //         : const SizedBox.shrink()),
            // // Example pay button configured using a string
            // ApplePayButton(
            //   paymentConfiguration: PaymentConfiguration.fromJsonString(
            //       payment_configurations.defaultApplePay),
            //   paymentItems: _paymentItems,
            //   style: ApplePayButtonStyle.black,
            //   type: ApplePayButtonType.buy,
            //   margin: const EdgeInsets.only(top: 15.0),
            //   onPaymentResult: onApplePayResult,
            //   loadingIndicator: const Center(
            //     child: CircularProgressIndicator(),
            //   ),
            // ),
            FutureBuilder(
          future: FirestoreHandler.getUserInfo(
              FirebaseAuth.instance.currentUser!.uid),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length + 1,
                  itemBuilder: (BuildContext context, index) {
                    return index != snapshot.data!.docs.length
                        ? ListTile(
                            title: Text(snapshot.data!.docs.first
                                .data()["ticket"]
                                .toString()),
                            leading: Text(snapshot.data!.docs.first
                                .data()["price"]
                                .toString()),
                          )
                        : FutureBuilder<PaymentConfiguration>(
                            future: _googlePayConfigFuture,
                            builder: (context, snapshot) => snapshot.hasData
                                ? GooglePayButton(
                                    paymentConfiguration: snapshot.data!,
                                    paymentItems: _paymentItems,
                                    type: GooglePayButtonType.buy,
                                    margin: const EdgeInsets.only(top: 15.0),
                                    onPaymentResult: onGooglePayResult,
                                    loadingIndicator: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : const SizedBox.shrink());
                  });
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ));
  }
}
