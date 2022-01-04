import 'package:flutter/material.dart';

class Utils {
  static void showsnackbar(BuildContext context, String content,
          {Color? backrgoundcolor, IconData? icon, Color? iconcolor}) =>
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar() //.. è detto CASCADE OPERATOR. MI CONSENTE DI FARE PIù OPERAZIONI SULLO STESSO OGGETTO
        ..showSnackBar(
          SnackBar(
            backgroundColor: backrgoundcolor,
            content: Row(
              children: [
                icon == null
                    ? const Text('')
                    : Icon(
                        icon,
                        color: iconcolor,
                      ),
                const SizedBox(
                  width: 8,
                ),
                Text(content)
              ],
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
          ),
        );
}
