import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_application_1/FirestoreHandler.dart';
import 'package:scan/scan.dart';
import 'package:images_picker/images_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String _platformVersion = 'Unknown';

  String qrcode = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Scan.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

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
            onPressed: () async {
              List<Media>? res = await ImagesPicker.pick();
              if (res != null) {
                String? str = await Scan.parse(res[0].path);

                if (str != null) {
                  FirestoreHandler.addTicket(
                      str, FirebaseAuth.instance.currentUser!.uid);

                  setState(() {
                    print("////////////////////////");
                    qrcode = str;
                    print(str);
                    print("////////////////////////");
                  });
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
