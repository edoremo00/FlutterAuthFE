import 'package:flutter/material.dart';

class Settingspage extends StatelessWidget {
  const Settingspage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
