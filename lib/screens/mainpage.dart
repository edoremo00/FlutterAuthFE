// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:authapi/models/authmodel.dart';
import 'package:authapi/screens/customerscreen.dart';
import 'package:authapi/screens/landingscreen.dart';
import 'package:authapi/screens/settingspage.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final Loginmodel? model;
  const MainPage({Key? key, this.model}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      Landingscreen(
          model: widget
              .model //deve essere widget.model.username e widget.model.password ma ho problemi nell'accedervi
          ),
      Customerscreen(),
      Settingspage(),
    ];
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
