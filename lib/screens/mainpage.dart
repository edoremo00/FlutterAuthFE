// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:authapi/models/authmodel.dart';
import 'package:authapi/screens/customerscreen.dart';
import 'package:authapi/screens/landingscreen.dart';
import 'package:authapi/screens/settingspage.dart';
import 'package:flutter/material.dart';

class mainPage extends StatefulWidget {
  Loginmodel? model;
  mainPage({Key? key, this.model}) : super(key: key);

  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  int selectedindex = 0;
  List<Widget> screens = [
    Landingscreen(
      model: Loginmodel(
        username: 'devedo',
        password: 'test',
      ), //deve essere widget.model.username e widget.model.password ma ho problemi nell'accedervi
    ),
    Customerscreen(),
    Settingspage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedindex,
        onTap: (value) {
          setState(() {
            selectedindex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'People',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: screens[selectedindex],
    );
  }
}
