import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_application_1/FirestoreHandler.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {

final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;
  

 
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            flex: 10,
            child: Container(
              color: Colors.greenAccent,
            )),
            
        Expanded(
          flex: 1,
          child: TextButton.icon(
            icon: Icon(Icons.add),
            label: Text(""),
            style: ButtonStyle(
                splashFactory: NoSplash.splashFactory,
                backgroundColor: MaterialStateProperty.all(Colors.black)),
           onPressed: () {
                    _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                        context: context,
                        onCode: (code) {
                          setState(() {
                            
                            this.code = code;
                            FirestoreHandler.addTicket(code!,FirebaseAuth.instance.currentUser!.uid);
                          });
                        });
                  },
          ),
        ),
      ],
    );
  }
}
