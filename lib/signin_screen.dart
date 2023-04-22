import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/FirestoreHandler.dart';
import 'package:flutter_application_1/MainWindow.dart';

class SigningScreen extends StatefulWidget {
  const SigningScreen({super.key});

  @override
  State<SigningScreen> createState() => _SigningScreenState();
}

class _SigningScreenState extends State<SigningScreen> {
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(
                  flex: 10,
                ),
                Column(
                  children: [
                    Text("Username"),
                    TextField(
                      controller: username,
                      onSubmitted: (value) {
                        print(value);
                      },
                    ),
                  ],
                ),
                Spacer(flex: 2),
                Column(
                  children: [
                    Text("Password"),
                    TextField(
                      controller: password,
                      onSubmitted: (value) {
                        print(value);
                      },
                    ),
                  ],
                ),
                Spacer(flex: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 135, 208, 241))),
                        onPressed: () {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: username.text, password: password.text)
                              .whenComplete(() => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MainWindow())));
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(color: Colors.black),
                        )),
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 135, 208, 241))),
                        onPressed: () {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: username.text, password: password.text)
                              .whenComplete(() {
                            FirestoreHandler.addUser(
                                FirebaseAuth.instance.currentUser!.uid);
                          });
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                ),
                Spacer(
                  flex: 10,
                ),
              ],
            ),
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
