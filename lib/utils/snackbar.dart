import 'package:flutter/material.dart';

class Utils {
  static void showsnackbar(BuildContext context, String content) =>
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar() //.. è detto CASCADE OPERATOR. MI CONSENTE DI FARE PIù OPERAZIONI SULLO STESSO OGGETTO
        ..showSnackBar(
          SnackBar(
            content: Text(content),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
          ),
        );
}
