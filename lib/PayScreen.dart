import 'package:flutter/material.dart';


class PaySampleApp extends StatefulWidget {
  PaySampleApp({Key? key}) : super(key: key);

  @override
  _PaySampleAppState createState() => _PaySampleAppState();
}



class _PaySampleAppState extends State<PaySampleApp> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('tickets'),
        ),
        backgroundColor: Colors.white,
            
        );
  }
}
