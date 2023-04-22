import 'package:flutter/material.dart';
import 'package:flutter_application_1/PayScreen.dart';
import 'package:flutter_application_1/UploadScreen.dart';

class MainWindow extends StatefulWidget {
  const MainWindow({Key? key}) : super(key: key);

  @override
  State<MainWindow> createState() => _mainWindowState();
}

class _mainWindowState extends State<MainWindow> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Commute',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          color: Color.fromARGB(255, 255, 0, 0),
          alignment: Alignment.center,
          child: PaySampleApp(),
        ),
        Container(
          alignment: Alignment.center,
          child: UploadScreen(),
        )
        // UploadScreen()
      ][currentPageIndex],
    );
  }
}
