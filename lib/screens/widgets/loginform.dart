// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class loginform extends StatelessWidget {
  TextEditingController controller;
  TextInputType? textInputType;
  bool? hidepassword;
  String? Function(String?)? validator;
  final String? labeltext;
  Widget? suffixicon;
  Widget? prefixicon;
  TextInputType? keyboardtype;
  String? helpertext;
  int? maxlength;
  AutovalidateMode? autovalidateMode;
  void Function(String)? onchanged;
  loginform(
      {Key? key,
      required this.controller,
      this.hidepassword,
      this.labeltext,
      this.suffixicon,
      this.prefixicon,
      this.validator,
      this.textInputType,
      this.keyboardtype,
      this.helpertext,
      this.autovalidateMode,
      this.onchanged,
      this.maxlength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      autovalidateMode: autovalidateMode,
      maxLength: maxlength,
      onChanged: onchanged,
      obscureText: hidepassword ?? false,
      keyboardType: keyboardtype ?? TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixicon,
        border: OutlineInputBorder(),
        helperStyle: TextStyle(color: Colors.blue[600]),
        helperText:
            helpertext, //mostrato come aiuto se non ci sono errori nei campi
        helperMaxLines: 3,
        labelText: labeltext,
        suffixIcon: suffixicon,
      ),
    );
  }
}
