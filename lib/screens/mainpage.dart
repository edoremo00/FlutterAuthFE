// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:authapi/authutils/tokenstorage.dart';
import 'package:authapi/models/authmodel.dart';
import 'package:authapi/screens/loginscreen.dart';
import 'package:flutter/material.dart';

class mainPage extends StatefulWidget {
  Loginmodel? model;
  mainPage({Key? key, this.model}) : super(key: key);

  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Homepage',
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.black,
            //ci sara immagine profilo utente dentro
          ),
          PopupMenuButton<int>(
            onSelected: (value) => onselected(context, value),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        height: 100,
        width: 300,
        child: Card(
          margin: EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Buongiorno, ${widget.model?.username ?? ''}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onselected(BuildContext context, int value) async {
    if (value == 0) {
      await Tokenstorage.removetokenfromstorage('token').then(
        (value) => Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => loginscreen(),
          ),
        ),
      );
    }
  }
}
